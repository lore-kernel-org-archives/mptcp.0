Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8419B3D8
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771758; cv=none; b=h+w8WKPNHNUzc5/syIDxPckfrCUYgjtjEPVIITWqMXTWDlblcNa42SPp7bVBg8Rwxn/YfucUnUvbdLqCVW6hzpLQcLHX4rHfSAezNKIgO2UkDR0G8I9KSK3gtM1rn9PpLFzkWpflZ7BPGVmH8qZEnMAXOTNk9EwFrpPlkV2sRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771758; c=relaxed/simple;
	bh=Rxok55OIaYMRCkr7w+pJrrsuiNoA+XVp+wHCdOMwtME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hKuMsjpJK3ifvuheaN1NBguu49rUBeCmi9Snl+QychI1DdOv+ROQfEjRJc5nPnuyWWb82yKl4aJF9vneAJ0WHL+LbHa9xO8TWAzR1g5decCDmdIvNRbdASNcNQmbdsSy459elxgPkQeWO+X0KzbQOTNKdVvIHsbesCsR68//FDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dsy9ZxI6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dsy9ZxI6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911uLjA021667;
	Tue, 1 Oct 2024 08:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Iwpj7p1XD+qmm68moM44LorMqFof/3LSSa1cf5DjdHA=; b=dsy9ZxI6vgwKywf/
	NHTqb+qtT7HnbiBErUggmuHUK2vCS3Lzuzt+duj0jEgdeHcxGjUXFo8ZBav5O2xV
	QIQk+Qy3D8ffFH6RnZZ/bmRXo0VYDu8JLsqhp30rzFVopKdDrNzXLJMNj9ltIrez
	NOoxOFCZsFcqL+SpiosAt1D/Fe8Q+LJpQagRDMRrx2H+pkSOehyzvRucabJ5Q97o
	/1RYTbY6MsmxB1re2NoMOz/71d2JPcijV2bX/qk7Syz2tKD1UNtdB+Cu4qGlzJ7P
	5nGy57VLSiyMOSOH90nskaSCC2yH48H+EAXLA9JeGhaQAa1kwUu71xdARhtd7k+8
	kr8oig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb6j51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 08:35:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4917JE12002356;
	Tue, 1 Oct 2024 08:35:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu12vsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 08:35:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4918Zk1d42009078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 08:35:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E93358052;
	Tue,  1 Oct 2024 08:35:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3290E5805A;
	Tue,  1 Oct 2024 08:35:45 +0000 (GMT)
Received: from [9.152.212.241] (unknown [9.152.212.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 08:35:45 +0000 (GMT)
Message-ID: <e352b1db-8288-4f98-a66b-955f8753b927@linux.ibm.com>
Date: Tue, 1 Oct 2024 10:35:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH doc] docs: gcov: fix link to LCOV website
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
Content-Language: en-US
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20240926-doc-fix-lcov-link-v1-1-46f250cb7173@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EDWsRrhGCzSh8doaz5MyNmk-QhFAQXVi
X-Proofpoint-ORIG-GUID: EDWsRrhGCzSh8doaz5MyNmk-QhFAQXVi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_05,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=721 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010055

On 26.09.2024 15:09, Matthieu Baerts (NGI0) wrote:
> The previous website hosted on SourceForge is no longer available since
> January 2024 according to archive.org [1].
> 
> It looks like the website has been officially moved to GitHub in June
> 2022 [2]. Best to redirect readers to the new location then.
> 
> Link: https://web.archive.org/web/20240105235756/https://ltp.sourceforge.net/coverage/lcov.php [1]
> Link: https://github.com/linux-test-project/lcov/commit/6da8399c7a7a [2]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Yes, let's update the link.

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
