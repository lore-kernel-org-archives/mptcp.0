Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487C3A6EF0
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930931; cv=none; b=Q+DBhHNC1Z/g4YfINA+UKzbYGKSfXlKk0pPT92wGnw0uWP4yPs3feOQC9FSrqxYggHmm3rl6GgOlNOM19tH5HdcIFw9A55si0xvUB2UlBcgvKfh/xmn3DS2UXW/wPYQZQ+9Y5WzQc3J+FtmQ/58maeQBOLZJlLu4iQtxkn+ZywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930931; c=relaxed/simple;
	bh=exD0nCyrIBd7fxxnQjMwqMRgDo3qY8S5mDQ4XuqLoWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLn5NoUKli2FUjsz9dpN1FpfqBObqy7NqMOKPL7CLUhATgpDJIKlp3QU4MCG+jiCS+n0EFehUxUr+zkBOGYpCsQu/PqLzUxiR/ZqyeXV4TQDOAyAxquGlMowB8gEvcyN1LjOyELiDb9MW5Z1TntcR4cDJLbdHDO5J/TRUEhNF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wwk61q+H; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wwk61q+H"
Message-ID: <0754e3fd-bb76-4acc-905b-17fcf59905ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783930927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TNVa47K7vdoSbFnpv6cNo/aVqY6M7TgTufOlocLZaU=;
	b=Wwk61q+HPGOhmJHKmcdw+K74KOJQ2Xdyh0NISkj45iR8RPrELsv747eyg30zf2anUKzUSL
	4ll0StniBxEAfoEyZAeya15s3XpQB2OHoRNexnQsi34Izoar8ltyY+2G9/QNC1Iptgbiau
	oN9FarpZa0p5FJe/Fw7dI/+pJopwXr4=
Date: Mon, 13 Jul 2026 16:21:14 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] mptcp: pm: fix use-after-free in
 userspace_pm_get_local_id()
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
References: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
 <b3c317fda3d8d3efa349933723e549933ffc0bf2@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <b3c317fda3d8d3efa349933723e549933ffc0bf2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/13 16:03, gang.yan@linux.dev 写道:
> July 13, 2026 at 3:47 PM, xuanqiang.luo@linux.dev mailto:xuanqiang.luo@linux.dev  wrote:
>
>
> Hi xuanqiang,
>
> Thanks for the patch.
>
> But AFAIK, geliang has fixed this in [1], and your test verified this issues.
>
> @Matt, it seems that [1](geliang's patch) can be merged.
>
> [1]https://patchwork.kernel.org/project/mptcp/patch/4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn/
>
> Thanks
> Gang

I see it now.
Indeed, I missed the pending patch;
Thank you for pointing it out!

Thanks
Xuanqiang

