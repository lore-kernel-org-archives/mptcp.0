Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097342563
	for <mptcp@lists.linux.dev>; Tue, 28 May 2024 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862622; cv=none; b=QHUBwppAlqnybTO3FyT1KHpd+7NsW8KjFwf4u2I6plolYACSS1exnKAW4CiLbaIEJ/wAKfxcwtUK9yPsqL8toe9umLpNStCU7dCAHHvflWfMG6f1qOxUevaqlMMd0owvFjNp/SXRUSZEC3eTLF2fXVe5UUbtUmGEp30kEQVqiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862622; c=relaxed/simple;
	bh=GM3GdEA3yqc+aO62+JScq5QPOxzYlg5Pl0C0y+BXQ1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KObnAyVhCosKFJfGUI0/7CQrHixiyd2+m8iQnEECr6FEKBAUTursuDwSvMAFs578x/qvgBQcpTH9TKkRETw020udF3e0ooOy2Ky6313oLN6JHg5UgmeW2bGUzc0GKqgLDYBlQ+If6iwec8QEwhKlgbnoqWVqgCnW/3TY0H/hW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:28022.494379523
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 9883A100112C9;
	Tue, 28 May 2024 10:16:47 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-67bdc54df-b7md5 with ESMTP id 882edb4b0be34c4f8898e9b24ee80432 for matttbe@kernel.org;
	Tue, 28 May 2024 10:16:50 CST
X-Transaction-ID: 882edb4b0be34c4f8898e9b24ee80432
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <5a7b526c-55c5-4dc3-86a4-633ef3242d24@chinatelecom.cn>
Date: Tue, 28 May 2024 10:16:43 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: make RMADDR MIB counter clearly
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>
Cc: geliang@kernel.org, mptcp@lists.linux.dev
References: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
 <208134576.5417.1716773783465.JavaMail.root@jt-retransmission-dep-59f6f76b7b-m2drk>
 <04c0fd97-1144-4480-9ea0-7e54645431c9@chinatelecom.cn>
 <6c127b7d-1659-45a7-a63f-db276d58dab7@kernel.org>
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <6c127b7d-1659-45a7-a63f-db276d58dab7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/2024 00:05, 【外部账号】 Matthieu Baerts wrote:
> Hi Yonglong Li,
> 
> On 27/05/2024 08:44, YonglongLi wrote:
>> On 5/24/2024 22:50, Matthieu Baerts wrote:
>>> On 23/05/2024 09:56, Yonglong Li wrote:
> 
> (...)
> 
>>> It would be good to modify the selftests to avoid any regressions later,
>>> and to cover this case. But I'm not sure how to reproduce your case
>>> where a RM_ADDR is received but for an ID that is not being used by the
>>> PM. Do you know more about your case? Maybe because the subflows have
>>> just been removed?
>>>
>>
>> I reporduce it just add a bcast ip addr which will cause join connect failed.
>> Like this:
> 
> Good idea to use this broadcast IP address. I just sent a v2 of your
> patch modifying an existing test, instead of adding a dedicated one:
> 
> 
> https://lore.kernel.org/mptcp/20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org/T/
> 
> Please tell me if it is OK for you.

It's ok. Thank you. :)

> 
> Cheers,
> Matt

-- 
Li YongLong
