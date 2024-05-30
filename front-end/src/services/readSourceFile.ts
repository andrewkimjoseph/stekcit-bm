// src/utils/loadSource.ts
import fs from 'fs';
import path from 'path';

const sourcePath = path.join(process.cwd(), 'src', 'utils', 'chainlink', 'source.js');
const sourceData: string = fs.readFileSync(sourcePath, 'utf8');

export default sourceData;