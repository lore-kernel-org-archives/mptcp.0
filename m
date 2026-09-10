Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB2470105
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038544; cv=none; b=svKJabN1yb14coegNMR+/IkmPvv+/5TnsKSGEdL3LLx9aUVcHloQCoPq5CTzLBkp3oEQF2Et0ZO6y7Znc8OuFjlpv+Go78K6ZsLRP7oAgNexO5QnepB6dKJ7zcgkECyPiQGekS5C4867PIIPT7eYF9Cn+kVdWSRaDJt90CtX2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038544; c=relaxed/simple;
	bh=YZJKBp1Xhz1wtl66ZjSk3W6Iyi0VyQ8+Z80goYlTkCM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=BEg2hWzSeys2FisWQGSnmZT7kPxTT+e+lCFdT2pZ1Mtrd2OfFXEjPefI6ImQ4cmX9pfjynjKwsQO6sgkGyZ24VySO2cztvr24tbpdMdradWAo+2mj14MX/IMKQqjmlecgPZShzzXNo7COeQu/UHx+0lsgOkuUPmsWEu5hLlMpW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fEK4HRs/; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fEK4HRs/"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=YZJKBp1Xhz1wtl66ZjSk3W6Iyi0VyQ8+Z80goYlTkCM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789038537; v=1; x=1789643337;
 b=fEK4HRs/yTIT7//J1dsC0bxNJ/3VVw4FsRsIzK7Vi8pHj0MQ8USSLiz4qdP8Qif2dHqSNBAW
 ux6xCVIzhPJNqAVk2qWRk9MSoliSeShIUoN6TAz/ArbRvxKlmHzIV0HIYj/5NTBwcMVqUGbzFIw
 mqkJ4ir0GFVor9zKiS1eUVKU=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 327d5b8c6aa10446;
	Thu, 10 Sep 2026 11:08:57 +0000
X-Mizu-Trace-ID: 327d5b8c6aa10446
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 11:08:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <703f2d892ac7432d4317f949e6ceba1b7f73ba40@linux.dev>
TLS-Required: No
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main
 MPTCP list
To: "Shardul Bankar" <shardulsb08@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
 <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
 <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev>
 <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
 <20260907125720.516598-1-shardul.b@mpiricsoftware.com>

>=20
>=20Gang, you mentioned deploying Sashiko locally. Did you see anything l=
ike
> the same cost, and what were you running it against? If this turns out
> to be particular to a fixed-quota subscription, I would rather find tha=
t
> out than have people avoid running reviews locally over a cost that doe=
s
> not apply to them.
>=20

Hi=20Shardul,

Thanks for your reply.

Sorry for the delayed reply; work has kept me busy lately so I haven=E2=
=80=99t had much
time to check emails. Please also excuse my English =E2=80=94 I might hav=
e caused some
confusion earlier. I'm using the API key and noticed the cost.

I=E2=80=99d like to share my experience with an API-key Sashiko deploymen=
t, which may help
folks on this list use Sashiko at lower cost.

I run Sashiko using Minimax as the LLM. Minimax offers a monthly subscrip=
tion plan
and is quite affordable. (I submitted a small PR to Sashiko to fix some i=
ssues
I encountered while using it.)

One observation: reviewing large patch series via the web interface can b=
urn through
the 5-hour quota very quickly. In contrast, using `sashiko-cli` from the =
command line
seems to cut token consumption significantly, this is from my practical t=
esting.

I also tried GLM, which is another fixed-quota subscription model and rel=
atively
more expensive. While its quality is not as good as Gemini or Opus, it st=
ill works
well for local code iteration.

I=E2=80=99m still relatively new to working with AI tools. If you have an=
y approaches to save tokens,
would you mind sharing them on this thread?

Thanks
Gang

> Thanks,
> Shardul
>
