Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8C348C77
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747015; cv=none; b=jp43t0mFkctue4XqHjP3jWY5WZ1wWPNzej1bO0SyNZ7Wf52OeGUuzTC9EjVjBlcY0GWMQ7iJUi3U8V/1PKYrCig4YX2DS/Gq7fb4JkL1Wwa3PzMhkjQsmwz2hOxNh0HGAo854gnS6KAJH5rw91604swZK9sRXazQQ/bc/xfYGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747015; c=relaxed/simple;
	bh=lpxNTE7ECn1+x6K6wtbWOaniQr4Ko85eW/4b/Zj5WhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ltl5NXwyhvSCAYiU+xwEU9vplHcc3BQVyYLK1CPOV9xs9GV6OdKMY8xC7J0TH7ueehuQTJAKMBiPIonRmohqszsSG4JKpCZmlziX/Wh6Dj2o7OgxCGk4oN5SV5PdmAgaj2H/B9lG3WaVppmVuDFSh5CA+CkMtBi1FtUnV92tz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7Mns6ZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7Mns6ZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64EE1F000E9;
	Fri, 14 Aug 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786747014;
	bh=DuPavqsgg8u9by4V0Zt5H9NyK665I1ri+ZT/K7TU400=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B7Mns6ZL+V3x4uC+lemJ+StOk8+BpLCLTGk2efF1koQMLQmbbeiRBnjZf6rkWuDmp
	 ecLRjfrBKsWJNAh+7HL56tWc0o9dOe3mSiqpBu7c3M9+CdoYl2cDEOsrhnjNNigTfZ
	 oLHdNvvMM1WKYFRPjAS/G/W8H2u27GZOxJlfBv33OHZ0ggdoDJ/GkBEDXPq8Jg4aUH
	 V9CIJl0kyX2lgsgmoKPIRD6sfRsWcD4A6AN1faI+R3KQibzKaKEB5WFlEXMwceHiLo
	 hMr2cx3yg08JfG7bS3GwodlQUE7xDAeYNk0+qWErRAL+H1rcHH/PlJ7ezOrcvSK6E+
	 4pvKop4DlqK2w==
Message-ID: <899ba654-b0cb-49a1-a481-884734985b77@kernel.org>
Date: Sat, 15 Aug 2026 00:36:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next] mptcp: annotate data-races around sysctl
 reads
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>, gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260814032749.2222975-1-cui.tao@linux.dev>
 <44897d3c50a4ce9db11d52c19382a2c9f648a62c@linux.dev>
 <d446f4a1-f100-453e-a952-5353505a465a@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d446f4a1-f100-453e-a952-5353505a465a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tao, Gang,

Thank you for looking at this!

On 14/08/2026 07:26, Tao Cui wrote:
> Hi Gang,
> 
> 在 2026/8/14 11:51, gang.yan@linux.dev 写道:
>> August 14, 2026 at 11:27 AM, "Tao Cui" <cui.tao@linux.dev mailto:cui.tao@linux.dev?to=%22Tao%20Cui%22%20%3Ccui.tao%40linux.dev%3E > wrote:
>>
>> Hi, Tao
>>
>> Thanks for your patch, but it has been submitted by Matt before in [1].

Thank you for the review!

>> I think Matt wanted change the PM and sched sysctl from string to atomically,
>> that may need another patches (READ_ONCE is not enough), right? If no, you can
>> wait for the other maintainers' reply.

Correct.

>> If yes, I still think this patch should keep author as matt, the rest of
>> others can be yours.
>>
>> Note: Some patches about sched is only in our export branch, not mainlined,
>> so it's better to do your work based on it.
>>
> 
> Thanks for the review. I did see #626 before sending and referenced
> it, I just read its scope wrong: I assumed the patch it links was only
> about the string sysctls and missed that the numeric readers were
> already covered there.

Do you plan to work on that? If yes, that's great, thank you. Just one
thing: if you are working on addressing an issue that is on GitHub, do
you mind adding a comment there to say that you are working on it,
please? Just to avoid having multiple people doing the same thing. (Just
to be clear: I'm not working on it.)

> And thanks for the export branch tip, I'd only been looking at
> mainline and didn't know some of the sched patches are only in export.
> 
> The only bit mine adds is the WRITE_ONCE() on the pm_type store in
> proc_path_manager(), to pair with the mptcp_get_pm_type() read. Matt,
> if you want that too just grab it, otherwise I can send it as a small
> follow-up.

Good catch! If you are planning to work on the other remaining sysctl,
do you mind taking my patch, add the missing WRITE_ONCE() to it + add
your co-developed-by + signoff to it, then add your new patch(es) on top
of it and send everything (including the first patch), please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

