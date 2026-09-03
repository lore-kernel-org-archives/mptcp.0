Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B62E1746
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416567; cv=none; b=urK7zScgzRsaKtHktaKXZwak0GB1X+KANKkFObbfqZQRji+XBHk/afKrPFTlhCkaLiNyEsMqWmEWIAp/qjTVG88Fdzomr7oXJW8+g2DPBF8sQMAZWdYr5AMRbrjJuCHr0hdp26jnVBgDukYpcMS3JUYOVNa1QVy4/EguJUBWJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416567; c=relaxed/simple;
	bh=FQlQWjQ9Md/mS5BiLT5g6G2CjEDfXp1y/3w8XnEjXQk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=DmZX98jMVn8+JgcsdUkEhXq+6xnx2SjacvScHS7Hd0pcoHeGc+Gbenp9wDGEbFB0ISbWEorOKbk/CK6kNXJKQr8qrlmmXUV56zR4y4mY6cK8KKIAGzUcASD+yM3hEwfVso8I1V9V4E6bZPPkTO9yr0XMSBeOXw1pkU5Ct+TNcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWS7maVm; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWS7maVm"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=FQlQWjQ9Md/mS5BiLT5g6G2CjEDfXp1y/3w8XnEjXQk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788416564; v=1; x=1789021364;
 b=XWS7maVmkyXlD1mA68Q4XV+eIpdYbuq3kIhIQxsafMOuCU7dYXrGyFzrEvVG11NuO1KWXDi5
 qt7339ilwlpATHcTudseNBjEe6TKTvwe/I8aRUeJfVmvD8rCgiYU/VvrV5ktjCxDS634dtkTk9u
 hV/dJXwZLsAOVjMeQg20PlPc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 868cb4d387e5504a;
	Thu, 03 Sep 2026 06:22:44 +0000
X-Mizu-Trace-ID: 868cb4d387e5504a
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 06:22:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <2e771c1355c7d5d3faf42feed55ced63bc5869cb@linux.dev>
TLS-Required: No
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main
 MPTCP list
To: mptcp@lists.linux.dev
In-Reply-To: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>

September 3, 2026 at 2:12 PM, gang.yan@linux.dev mailto:gang.yan@linux.de=
v  wrote:

>=20
>=20 I believe both sides will benefit clearly if the sashiko process is =
mitigated:
>=20
>=20 1. For reviewers/maintainers: Their main list inbox will only contai=
n two types of patches=E2=80=94brand new
>  submissions (v1) and "mature" patches that have already passed the bot=
's checks. This drastically
>  reduces noise and allows them to focus their limited reviewing bandwid=
th on patches that are truly
>  ready for human scrutiny.
>  2. For contributors: They can iterate as fast and as often as they wan=
t in the sub=E2=80=91list without feeling
>  guilty about flooding the main list. They get a "safe sandbox" to poli=
sh the series until it meets
>  the bot's criteria. When they finally post to the main list, the patch=
 is already in a much better
>  state, which should also speed up the human review process.
>=20

Having=20said that, I realize this might be an overdesign. If anyone else=
 is bothered by the sashiko process
in a similar way, please leave messages under this thread, maybe we can f=
ind a lighter approach.

> I want to stress that this is not a complaint or a demand. I fully resp=
ect the work that has gone into
> Sashiko and the current process.
>=20
>=20Looking forward to hearing everyone's thoughts.
>=20
>=20Thanks
> Gang
>
