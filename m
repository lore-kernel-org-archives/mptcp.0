Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C2357CE5
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071422; cv=none; b=e//kkrizQ19ozwpnRVo1hYQkRgyiaBogdnjGEv5OxPl4Wg9/i0qAP+0a9nRUOBXswtctJvmljNrhtm/FVIxQKNopgV6NTLluXG2R/nZJ3a3uQNbCJBE27q52l1j6eZGSoNcF4jJdN88l/2PcE/nxRwJiJlbkrhi6t7aibqXfSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071422; c=relaxed/simple;
	bh=TL6Q82hdY00/3pK3uQb9H9GKYpX9vZ/Yexp7w4BKbeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH6cZbnzWHu6u/K+DWSqSQVMU8gSEl3MsZNycaRblbkG6seU7ElQ0njlVUanwH7RUV0nvNYn6ozPWtxp2JRWaSuEyqCQwgMdLryy+4t2s2XYepZk13ipP36PzYy6mbmKbR0fBfUpS+MoS1qN3DBHleaD79TI30Jfy0cvDatwp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YvJcNubw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YvJcNubw"
Message-ID: <40ed6489-e9df-4533-80bb-78683fbdfb88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783071419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXEoIJbmtjHwJUgjh8XL93jkYKPJ5T9ZfRE/NirIEww=;
	b=YvJcNubwqjhiLkSHJIgq3fbaRDyD/X6P/G7nmKBn3ZYMR7TudxEm+zEKWF9v9K50tizeD/
	I+8gN/Il5K8HOMZXWXUwmeVlj878x9vmMw9DIIJEkRpbBaNIIhRFxK1YmrlI7JXyGVzZZn
	agRZ9Jkd8QEy84X0PWSw7BeJoLCvcqI=
Date: Fri, 3 Jul 2026 17:37:04 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-net] mptcp: fix extra_subflows leak on failed
 passive join
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
 <178281645760.2535326.10938187030246254056.b4-review@b4>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <178281645760.2535326.10938187030246254056.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Matthieu,

Regarding the sync join failure, I have already submitted a PR.
https://github.com/multipath-tcp/packetdrill/pull/200

Thanks

在 2026/6/30 18:47, Matthieu Baerts 写道:
> Hi Chenguang,
>
> Thank you for the fix.
>
>> mptcp_pm_allow_new_subflow() increments extra_subflows
>> before __mptcp_finish_join() on the passive MP_JOIN path.
> I see that this code path is currently not exercised by our test suite:
>
>   https://ci-results.mptcp.dev/lcov/export/mptcp/protocol.c.gcov.html#L4031
>
> How did you spot the issue? Do you have a reproducer? Or was it by
> reading the code? Assisted by a tool (in this case, please add the
> Assisted-by tag)?
>
> I see we have a test for sync connect failure, but not sync join. Do you
> mind adding a new Packetdrill test please? Similar to simult_connect.pkt
> I suppose:
>
>   https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/simult_connect.pkt
>
>> On synchronous join failure the subflow is dropped without
>> calling mptcp_close_ssk(), so the counter is not rolled back.
>>
>> Call mptcp_pm_close_subflow() when the join completion fails.
> A fix patch should always have a Fixes tag. Here, I guess it should be:
>
> Fixes: 10f6d46c943d ("mptcp: fix race between MP_JOIN and close")
>
> Apart from that, the modification looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
