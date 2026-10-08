Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99C4349AC
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466297; cv=none; b=H/Vc1vj6OmEmOYtOj78sObASye85SWgSTmCMfwNItbTKXitktBtt7tIPiBE4jEJAkSyoI5D+bazWpO2Lxz4QwCLv1MrnYV72DPXj13ueOg2+L9aPy0LaWGQ/DT28xeGwVmcUFi7XjM+inXFpxpPycDBraoc2OrX0sUGq7u58pT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466297; c=relaxed/simple;
	bh=673WcoRVoNSUhl4DIjMqO1Lrlzm13M/OEkPHH0nqklY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=K/57kXqBjZWCx6rQ6NXt2bP79ylrQoMnCwmgq1VJ7Q3ajcUMfqhDnaLvATpeTEb3xpPKyScz0oVK9Nr26pvu9/87Mtel+dcF0mR9ExlFGSw7MVOwVtPxqHoCpJG0Oqkn3rLDdQWFrxZtoSLAelFti/ZHZkFSEPgnpL75+uBlmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQOtcCIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQOtcCIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48D11F000FF;
	Thu,  8 Oct 2026 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466295;
	bh=PGtE4iETYs8kA6PAEjtoNN2QVYE00l0j4tuEYQlDiAk=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=PQOtcCIJ4L7jDff1X9kWDBrYMYKz5uVrFj1K9I5tAo2vK2V+myEs/osh0LZ7o+xNx
	 pHxF6azsYYDPagoOFVwlPEXtLTGaLtMsbWFY3GEK1VjnGvKmWzMETjwKEdtShMy72I
	 O4MO17zUQEwB4t//ybcJznIHc8uVeSdt2lVSvD37SVfefuoJ8BhpXjl8fQgRxjKUu5
	 9+75jPh6fNqaBDzgBIiqIftZ2Hs79xZGS1N0p68l0OD76cjBDaoPf6+MtLr/zLmoee
	 vGMS9SKpDDpK7iosg2cTwcWx0Ro6jW6DiO53zRbiYFNZ+Z830SUhlKgYUGMJvupYKE
	 O1bXxsmkjeMBg==
Message-ID: <a1ed275c-d455-480c-b12c-d44eeedbed65@kernel.org>
Date: Thu, 8 Oct 2026 15:31:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: T S Rameshkumar <Rameshkumar.t@phytecembedded.in>
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
 <a6269e21-a506-4607-b39a-3b4d2e4cccf6@kernel.org>
 <PN0PR01MB9382C18780E137E3013A097CF4932@PN0PR01MB9382.INDPRD01.PROD.OUTLOOK.COM>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, petar.sakic@ink.fish
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <PN0PR01MB9382C18780E137E3013A097CF4932@PN0PR01MB9382.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2026 15:06, T S Rameshkumar wrote:
> Thank you for the detailed feedback and guidance on the workflow!
> I apologize for sending revisions too quickly without giving enough time
> for review and discussion. I will make sure to pace subsequent
> submissions properly, base patches on top of the MPTCP "export" branch,
> increment version tags (v2, v3, etc.), and include changelogs using b4.

Thank you!

Please keep the discussions on the ML (and reply in plain text, and no
top-post [1]).

[1] https://subspace.kernel.org/etiquette.html

> Regarding your technical questions:
> 
>  1.
>     Clearing is_mptfo:
>      1.
>         You are completely right. An automated bot flagged a potential
>         bitfield data race if is_mptfo were cleared concurrently.
>         However, since check_fully_established() is only evaluated once
>         upon receiving the MPC third-ACK, clearing is_mptfo is not
>         needed at all. Since is_mptfo is only read after subflow
>         creation, leaving it in the bitfield and uncleared (exactly as
>         Petar drafted) is completely race-free and clean.

Thanks!

Please also send a regression test for this, ideally with Packetdrill:

 https://lore.kernel.org/bfd64e10-7f1e-41f6-ad12-12f06c4d2880@kernel.org

>  2.
>     Attribution:
>      1.
>         I will definitely add "Suggested-by: Petar Sakic
>         <petar.sakic@ink.fish>".
> 
> I will wait for Petar's response and any further review comments before
> submitting v2 on top of the export branch.

Sounds good to be. But it will be a "v6" then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

