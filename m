Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F731D88B4
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779411775; cv=none; b=GrZmvhBQlXHTyqJtw/mrKvO3/SuBIs5gFfgNNjKXyNAk6DiVMiGwi7Aj+ndQUv1k/Vje8QlHAKgWnMdsD1d1ZqbamsHZ1uWhqCgjY5Th/oyB7MGWj/R1KhyxBoiPE4MbMDHSLiMk6MbUtCsQSOHcAu4+Yf4pRDW9d1yLcogfXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779411775; c=relaxed/simple;
	bh=KkVGUo0n/A0QW3VnEtiaWhn/xs12vSPwjG6o3ewPzZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHwIBHIQrCXlhqOIqg2gTlNkIcu5TcL+yrPokjkclqyl9P27SjNAxV6f3pJFUV10JvAZIqDgsyY0JZ9P08UdhP8iN7FHPkhIqfsAeRwpqrawR/zvXPvfItZhs+K/uDbSqTD4qp1kMZwIcmRQbIh+sN/3T+l/ItVO9G2hPtQgeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFBZ6oUB; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFBZ6oUB"
Message-ID: <703f5090-c386-48c5-8678-1d318f50edfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779411769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIJjxAazut7F3R/laMaGy+EyZhsEks+vxftwd8Ud/NU=;
	b=LFBZ6oUBABMsjBh76bs7t6P3jMl4Ct86013hiJEgELXAIwBn5cSokAVI1e3cflIu5z0yUx
	QZdDEBPEbdjCMMG7+cr7D+iWlQMQ7wEBLoYfLrtWzQz5+erJLn4myBuP5TywLgdj31PhOV
	KMSAc6B+2h7cLjpCFg+UD+Z+0/iNKQQ=
Date: Fri, 22 May 2026 09:02:42 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [RFC mptcp-next v15 00/10] NVME over MPTCP
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Hui Zhu <zhuhui@kylinos.cn>,
 Gang Yan <yangang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
 <2920ebf8-be75-434c-8566-e09910402325@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <2920ebf8-be75-434c-8566-e09910402325@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/21/26 09:57, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 20/05/2026 14:17, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> v15:
>>   - patch 3:
>>     - simplify mptcp_sock_set_tos(): remove unnecessary ssk local variable
>>       and state check (TCP_ESTABLISHED).
>>   - patch 6:
>>     - update commit log to explain regarding sashiko's concern about
>>       introducing "mptcp" as a new transport type
>>   - patch 7:
>>     - fix mktemp template, use --suffix=.raw to ensure 'X'.
>>     - move trap cleanup EXIT immediately after creating temp file.
>>     - remove redundant rm -f "${temp_file}" in error paths since trap now
>>       handles cleanup.
>>   - patch 10:
>>     - update Fixes tag.
> 
> Thank you for the new version!
> 
> A follow-up of the discussion we had on the ML:
> 
> - How is NVME over TCP typically used? Is it in a data centre, with the
> NVME device being very closed to the server? In this case, there might
> not be any losses, and a very low latency.
> 
> - Also, do you know how is NVME over TCP being used with the multipath
> feature? If the different paths have the same network conditions, then a
> "bonding" (LAG, etc.) is something that would work better than MPTCP: no
> need to retransmit, reorder at MPTCP level, etc. → But this only works
> in specific conditions. MPTCP would work better if you take different
> paths, with different latency and losses. But is it how NVME over
> (MP)TCP is supposed to be used?
> 
> (To me, NVME over TCP is a feature for data-centre, where the NVME
> devices are next to the servers, without many hops in between, but I
> might be wrong.)
> 
> Cheers,
> Matt

To my knowledge, the NVMe-oF protocol is at the heart of this ecosystem. 
Based on this protocol, there are already user-space and kernel-space 
initiators and targets available. Both the Linux kernel target and the 
SPDK target provide storage services, with no essential difference in 
how they are used(except performance difference). The Linux kernel 
initiator can emulate NVMe devices, interface with the kernel’s generic 
block layer, and provide POSIX APIs through the file system, allowing 
applications to use them seamlessly. A typical use case is leveraging 
software-defined storage capabilities in cloud-native environments; the 
Kubernetes community began working on a CSI[1] plugin for this in 
September 2021.

The user-space initiator is primarily used in virtualization scenarios. 
QEMU, using libnvmf[2], delivers better performance for virtual 
machines—approximately four times the IOPS compared to iSCSI. Unlike the 
kernel-space NVMe multipath support, the user-space initiator lacks such 
capabilities. However, if NVMe-oF supports MPTCP, it would greatly 
simplify multipath support in user space.

In data center environments where NVMe-oF is deployed, the expected 
network distance is short, latency is typically low, and bandwidth is 
relatively high. With the growing adoption of RDMA, mixed scenarios 
involving RoCEv2 and TCP are common. RDMA traffic usually has higher 
priority and larger volumes, leading to traffic contention between the 
two. Additionally, low-probability switch hardware failures can occur in 
data centers. In the worst case, when some ports on a switch fail, MPTCP 
with ECMP-based uplink traffic increases the likelihood of keeping 
NVMe-oF operational.

[1]: https://github.com/kubernetes-csi/csi-driver-nvmf
[2]: https://github.com/bytedance/libnvmf
