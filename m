Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F101E5207
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413077; cv=none; b=KAczftNtYNn+5zGELUdAoYqetALre/amMeiRY6krDn5Dgkmi1Fy0bEV57MzaDydxRu+PeAwfCegW3/X+GORv1zDXnwYGBV9KmIKDgMPOAPG+qt7XuLSLeOMah9dizuGnq9+QGmUH54sZHHn7fXbLdg9alDwhktn+cXxUWDlIRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413077; c=relaxed/simple;
	bh=1z1cj7zKDa3T0pJ1MS/Mcz7c4nDOdDrG5p8Z+ODW+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT0iwMMWO7+/dRiNOW0qBzYw3ovF1jJQPK1P5xzSWzEwdNk4zvvJxX6ha1r52vc2t+T7X3fR5PfXtXFYzACMEheABOpL3ohqSvff163MzmMqr4DkaoLZH9aKAS+JNXQr0rla8lFn5V+FVSDrzZTDQjDcqobfHQ1gJshcjaHe+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhCKNfie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhCKNfie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDAF1F000E9;
	Fri, 22 May 2026 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779413076;
	bh=rbTkc9+aFceskiZuw6fAcV+AUbJX+oG9r9jAWSiP3PI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JhCKNfieBKc+hI/+NAO130ZoFgQb0ZodJ7+u6+lfhdJ3ZvsUHRrg6/mZ5eRBIKDVn
	 dRlG0iC6c4AhthH4RRe/HoNVSh1S8SorcxJU+J/C3Q54kNU78SIdFZD+vJ7IpObUK/
	 A+g7txrwn8dmEd26QwfPi3FKomG+b7v9ePlrfeVfhwjv/FKzmLMHp04uyD5Svmx29N
	 FC1z/R9FhRRBkOtBtGSFGwyTAPpuzJelmKhQDUAd85NyfaDz0jT1EaUTs0SfAh5ZB9
	 MLpcqMwAR9kJ0M8UJ5hdQPlBwPo7gPD4Cqwlo/8fvqfKVmzMPP8YCv8EBvZ2X7r8Rp
	 KUBDZENJ6pPIQ==
Message-ID: <de6a7219-f5f8-467c-8492-07cd744eced7@kernel.org>
Date: Fri, 22 May 2026 11:24:28 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC mptcp-next v15 00/10] NVME over MPTCP
Content-Language: fr
To: zhenwei pi <zhenwei.pi@linux.dev>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Hui Zhu <zhuhui@kylinos.cn>,
 Gang Yan <yangang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
 <2920ebf8-be75-434c-8566-e09910402325@kernel.org>
 <703f5090-c386-48c5-8678-1d318f50edfd@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <703f5090-c386-48c5-8678-1d318f50edfd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi zhenwei pi,

On 22/05/2026 11:02, zhenwei pi wrote:
> 
> 
> On 5/21/26 09:57, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 20/05/2026 14:17, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v15:
>>>   - patch 3:
>>>     - simplify mptcp_sock_set_tos(): remove unnecessary ssk local
>>> variable
>>>       and state check (TCP_ESTABLISHED).
>>>   - patch 6:
>>>     - update commit log to explain regarding sashiko's concern about
>>>       introducing "mptcp" as a new transport type
>>>   - patch 7:
>>>     - fix mktemp template, use --suffix=.raw to ensure 'X'.
>>>     - move trap cleanup EXIT immediately after creating temp file.
>>>     - remove redundant rm -f "${temp_file}" in error paths since trap
>>> now
>>>       handles cleanup.
>>>   - patch 10:
>>>     - update Fixes tag.
>>
>> Thank you for the new version!
>>
>> A follow-up of the discussion we had on the ML:
>>
>> - How is NVME over TCP typically used? Is it in a data centre, with the
>> NVME device being very closed to the server? In this case, there might
>> not be any losses, and a very low latency.
>>
>> - Also, do you know how is NVME over TCP being used with the multipath
>> feature? If the different paths have the same network conditions, then a
>> "bonding" (LAG, etc.) is something that would work better than MPTCP: no
>> need to retransmit, reorder at MPTCP level, etc. → But this only works
>> in specific conditions. MPTCP would work better if you take different
>> paths, with different latency and losses. But is it how NVME over
>> (MP)TCP is supposed to be used?
>>
>> (To me, NVME over TCP is a feature for data-centre, where the NVME
>> devices are next to the servers, without many hops in between, but I
>> might be wrong.)
>>
>> Cheers,
>> Matt
> 
> To my knowledge, the NVMe-oF protocol is at the heart of this ecosystem.
> Based on this protocol, there are already user-space and kernel-space
> initiators and targets available. Both the Linux kernel target and the
> SPDK target provide storage services, with no essential difference in
> how they are used(except performance difference). The Linux kernel
> initiator can emulate NVMe devices, interface with the kernel’s generic
> block layer, and provide POSIX APIs through the file system, allowing
> applications to use them seamlessly. A typical use case is leveraging
> software-defined storage capabilities in cloud-native environments; the
> Kubernetes community began working on a CSI[1] plugin for this in
> September 2021.
> 
> The user-space initiator is primarily used in virtualization scenarios.
> QEMU, using libnvmf[2], delivers better performance for virtual machines
> —approximately four times the IOPS compared to iSCSI. Unlike the kernel-
> space NVMe multipath support, the user-space initiator lacks such
> capabilities. However, if NVMe-oF supports MPTCP, it would greatly
> simplify multipath support in user space.
> 
> In data center environments where NVMe-oF is deployed, the expected
> network distance is short, latency is typically low, and bandwidth is
> relatively high. With the growing adoption of RDMA, mixed scenarios
> involving RoCEv2 and TCP are common. RDMA traffic usually has higher
> priority and larger volumes, leading to traffic contention between the
> two. Additionally, low-probability switch hardware failures can occur in
> data centers. In the worst case, when some ports on a switch fail, MPTCP
> with ECMP-based uplink traffic increases the likelihood of keeping NVMe-
> oF operational.
Thank you for the explanations, I better understand there is not just
one use-case :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

