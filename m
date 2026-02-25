Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7983B8BC9
	for <mptcp@lists.linux.dev>; Wed, 25 Feb 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032036; cv=none; b=E71fMAetyrQMkd1xErJGc+cux0HBJwWc6hfX0VUwlIc87WJO/q8Ia1K/cN1kAErm7sQBd01mZ7pYF6YHHZikGeHGSW13Ja7kfSl1YEkhM3w/piN/cISFqTpN/5rmFx8oLX+0T9YHHLE0elalQxl6/4mYcLc0WlgvLYEr0UEi6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032036; c=relaxed/simple;
	bh=3mz7FRjZ4MyIyVUYbo/sGJgle7jeRR5W12Q63Qdz6Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNblPbXfFGjW8rb1MvPEqXkVPJsY9P8nJ0d6tuGAH+2i7rkSeB1XQfSeP5GNZILZAwp7/qeSh6Pwddz+PVV8uQ6KYqAK3gkt70f08rB+Wzps891Ny4le/b8BK2v/t1yZF+4LL6fwsuXg4iqQVpqVDdjUTHHocv/6q25zegAZ6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JpB0OfRw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JpB0OfRw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDoWAs2750096;
	Wed, 25 Feb 2026 15:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3fteOk
	Nv5xdSfCAEjgwGXl49Z8wnDkH7VR9i81uuJh0=; b=JpB0OfRwh59RPPEDl4fUci
	BDdmpf0cBWJF/nyhrsZbLIQBLLPpbpKm7h7FkVE/xG0X8SsSNuxRG6/dvmmDoycO
	gzMS5x3UJlxPJLiq3LxmClVS1cUgdRBUWKlMOZxj3BIbDV4Fz3SilUQpiVWtmsmI
	y+9gymDeGqLMQ0OBruBehUGo4mxoIxooE31rxS7YoQYx2G4pwQz88xHkgShBrkem
	BlRQ8SIwSloFJgAvHD4UJh1d2jxe8BrWwqjHs9dMVVQ/fYMkM/6zmMm364wlLpNf
	F8HruEFQ98JFkqTjMqKvX4c97zgWY6HJ90eRZpx+Z+yvqKzTrs9LajRijX65/xWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4720u9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 15:07:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PC3pAH013406;
	Wed, 25 Feb 2026 15:07:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy5uyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 15:07:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PF77lw26542812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 15:07:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA4E58043;
	Wed, 25 Feb 2026 15:07:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17F1F5805D;
	Wed, 25 Feb 2026 15:07:03 +0000 (GMT)
Received: from [9.43.9.170] (unknown [9.43.9.170])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 15:07:02 +0000 (GMT)
Message-ID: <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
Date: Wed, 25 Feb 2026 20:37:00 +0530
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
To: Geliang Tang <geliang@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Hannes Reinecke <hare@suse.de>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o4yHT0Y6Ipf_NKyOCT9Rof1HsuruXP4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfX8HOaGhAHdkch
 wI+Iyd0YTjp+9dkDsGz+TKjiOM8t9P8w5ZyQ9svMdLnGYeu2pmOq4pK8S4qExzK40ne+0QRoej6
 yDLmGs8GwUfyORc+Kc2zfnkwz4FBsUUMAcaoIsvhs9cnnxBWa+nQICIw3aiRTH9oVafpW51kUqO
 ULqnP+r90WuumtxXvCp1D3Db77FWHOYtEr4doSZyfl3AFUHOezXFeGekRRSPgHg5IXU8CeRaG7X
 NYjU8wOtbHraiXGTga0sdJUKFItHjaKUIDAqjiwl1dlf4CDqZti4eczVPohpXYrYgfq6Qam05fZ
 LrLxEu1rhUSkFVzRpeb/0oM7JjadHEIwkfFU78JP2IwW39YdbuDWUpNOrgZQxfz+dZ6LoDQGXzR
 ccrKizo6rV15P/qN6xuRoKfCSr9Um+LUfV3V6N7WIlEr6k5MFbeIkqWe/O0sYjp7n338s7/s/c2
 bbLpFHK9EaoWd3Cd4GA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f101d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Avx83NJuEvaYE25EaHwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o4yHT0Y6Ipf_NKyOCT9Rof1HsuruXP4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140



On 1/29/26 9:43 AM, Geliang Tang wrote:
> 3. Performance Benefits
> 
> This new feature has been evaluated in different environments:
> 
> I conducted 'NVMe over MPTCP' tests between two PCs, each equipped with
> two Gigabit NICs and directly connected via Ethernet cables. Using
> 'NVMe over TCP', the fio benchmark showed a speed of approximately 100
> MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s with
> fio, doubling the throughput.
> 
> In a virtual machine test environment simulating four NICs on both
> sides, 'NVMe over MPTCP' delivered bandwidth up to four times that of
> standard TCP.

This is interesting. Did you try using an NVMe multipath iopolicy other
than the default numa policy? Assuming both the host and target are multihomed,
configuring round-robin or queue-depth may provide performance comparable
to what you are seeing with MPTCP.

I think MPTCP shall distribute traffic using transport-level metrics such as
RTT, cwnd, and packet loss, whereas the NVMe multipath layer makes decisions
based on ANA state, queue depth, and NUMA locality. In a setup with multiple
active paths, switching the iopolicy from numa to round-robin or queue-depth
could improve load distribution across controllers and thus improve performance.

IMO, it would be useful to test with those policies and compare the results
against the MPTCP setup.

Thanks,
--Nilay
