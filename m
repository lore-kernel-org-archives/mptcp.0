Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122255;
	b=FjEBg10IyJVgjCnW5wYm5uMSuZP6wSZhJKp+9l22M9DmWoME0RxWBFc66iDB27zh5+Ea
	 Hw8NBDzdGqAjYt4WXokZujvJwDCteMNqXLYfs3mxBd+UyaLQ3X6Luwag+DPoK17MRDYY3
	 mIDUQyj6pcRC0FXeXDmAy/RWMkJDNOuUmLYYwkZM9EFuO1p4s+MMKKuZEuzpAFPEKzOJb
	 5x3Bsd5XW8abCHgGae5N5fPNVDOymVOxEHRgWMcp+KUCiOT2xhghfMAYg00iogeaOc8Vz
	 4o7jqw8g1Pg5qeFjAcCktNY7+xkd354hftaQwMpk4JX+4EW3E+YQMHuBdDzqb7FkZGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=tWQexhCXwRkqiAw5AoxPEkb5ll2oLfc/hc6VYGYxW6U=;
	b=hefxkUJVsagbIiDRDwwANxmnxNaPtinpk14hou6DzdOhzSy78bjRttYPA7R9M4awZpns
	 3UxNWO/S1YmtIHwfifq9PM7GlT068gdNl9zvYmC6zESB68RGhw8uzgJrejA/cbYsWtl2f
	 jdefTJvZvjdrCxbvmNi9lqYjMo74rHvwXSAeRlLfay3fNyu+LahLi78bJtcLfNgKCr+na
	 hrKi2FlD2K8d/+LK5sEl/ZhDhjRHiqDPunlW5HGU+SBSrkpYr96MiJsWqqLLeSf09cYbh
	 f4/6P99ymBDPpoH3FVrJNFeoRjfkw78WwWKrxkG5tSVScDYEXZx+IQrfhqWow+I4VMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5tv1hED;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638D606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B638D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5tv1hED
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso206480c88.1
        for <mptcp@lists.linux.dev>; Sat, 07 Nov 2026 23:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794122254; x=1794727054; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tWQexhCXwRkqiAw5AoxPEkb5ll2oLfc/hc6VYGYxW6U=;
        b=l5tv1hEDKFtaZy89BMiiDl5m3FZ59cYIm9rVxA+NQZcKi7A7N06i06DLlSAWB0lVpx
         PXdjqCGTs7s1CtE46Fh92fMfykbSAZjMZZjcoPDlLYTb26aap2RuMWMu1LxFZ6otRLGQ
         ro/aq+BBZJhlevR3XIYZRPXgDTMDKjkkNjD8cPemJ+Y3A12GQZ+2gJ4JJ2TnpwkB5q9Y
         aTDV8BQsoythA4bCJQvRn6hGLVUG860Z43UfO1XuYpUaU5cApbH56QzHEafBGFajzMpM
         P33HCObSZ523eKq3HCJ/qgMWvUplEKlHc/tH7n0Gr9vNlB8uJTaSQ6WXkJhECZjqph0U
         LgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794122254; x=1794727054;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWQexhCXwRkqiAw5AoxPEkb5ll2oLfc/hc6VYGYxW6U=;
        b=DE5w2uOxJNiaTED0dYiypVQ7i0IqpjMgEmnX6cZ4vjukzwGG4emp8hYrTYZbrouVx9
         XiMme6POd4FlqDJYg1xcPIucsSb1gGGaxzmWUAALZaztMEGjyBkX6Sl+sZJOZszDcGiP
         EAJZH0OJTAP8p6TWJ/yROFQkCZk2veXGLV70bRVupeUHuxpynFp+xmWoti8JqUu2y/zb
         fGjk5IgTtvoM+g0lUtq8NSbMYvIB+Yp5+t0TWa2t4D1f+7zFO31m3o7wKOOn2WRlLjI7
         zfxe7iLDrgdOSLPVRmDpAM0AmjcqLJ0Pvv5Pg8OgPDOc1v7+ONlt/Naz1xogmpclU70y
         XlRA==
X-Gm-Message-State: APuU4Z/PD9hP4puKnIDC1fRRBWvzAKjuyt0jHrOqufFoYrQuoZK/3rtH
	MuHt2v4T6avSw/z5U7qmJP+U/ylJSHkm77YxLBae2u3nzwdrpipm4UW8
X-Gm-Gg: AYBFou1bijIJgXcBJ5kWLWzEoR8gBfYNhrYoHs7NgQLqI/Ib8VKX7NQe7p0KVp3KFf5
	jaivATIC/76SM83DyKSY3vQ6DO1jVXCm3iguMKIE7dUS3K61oScbHBLvNbSDo1pF4AOUX/kQ7NS
	eSfaSWRr/BNQwFf2QN7tKBhELFRSGOnHadIEaqQ9XM+d3VKtJx32sLRlzHJCo+bTbj8vV4w+qTW
	DW5CG9dfK57o2uOzI+TSl6xLCvI3nu98haFwiWWFPKIs/Q+/ZZ2fovLoD4CdIMK+/BSwPvlWyTf
	p3KJ04ggq8bEzCo++kt+POE+ynbo4mxQpTy8qfYFsf4IgCm4298uvb+TFRri6VO3wqebT/51kiz
	tohWhL5Pihdhj/0XzY3bxid6dNGMxXfi4PwELc/Txz4E70nZyDFmzoSkXYnb0wPGgyMjkVgq9qB
	lCckL+o8pAZ9v8ddwLaqrhpGsPhmbMySZlLbRfVkYvhJEaxUs9b9A86Do82/gb8dsQ5jkbpXndD
	S5lTdp4P7RhdFzJ3SypFWh+S0jZh8Psp8cT4GsKRs8zbTnHtR8sEXGzVUqoyr4f7sYW+vSPbpw0
	ybWqRa4IF0Vyihmfd8I9d9eJOgpI9Evqay/kNxAbs6QlvukyBfoNax9I/szYrMLBPlk=
X-Received: by 2002:a05:7022:288:b0:1b2:43cc:48 with SMTP id a92af1059eb24-1b39feb25ffmr1262671c88.33.1794122253555;
        Sat, 07 Nov 2026 23:17:33 -0800 (PST)
Received: from [192.168.1.12] ([223.233.81.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm4347251c88.6.2026.11.07.23.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:17:32 -0800 (PST)
Message-ID: <a7d1f41a5cee6fbc0e1efb6b023a51af1eb2b666.camel@gmail.com>
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main
 MPTCP list
From: Shardul Bankar <shardulsb08@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, gang.yan@linux.dev
Cc: mptcp@lists.linux.dev
Date: Sun, 08 Nov 2026 12:47:29 +0530
In-Reply-To: <b9a44b9f-0cb9-4420-8860-92763264dd1c@kernel.org>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
	 <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
	 <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev>
	 <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
	 <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
	 <703f2d892ac7432d4317f949e6ceba1b7f73ba40@linux.dev>
	 <b9a44b9f-0cb9-4420-8860-92763264dd1c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Matt, Gang,

Sorry for the slow reply.

On Fri, 2026-09-11 at 11:58 +0200, Matthieu Baerts wrote:
> Hi Gang, Shardul,
>=20
> On 10/09/2026 13:08, gang.yan@linux.dev=C2=A0wrote:
> > >=20
> > > Gang, you mentioned deploying Sashiko locally. Did you see
> > > anything like
> > > the same cost, and what were you running it against? If this
> > > turns out
> > > to be particular to a fixed-quota subscription, I would rather
> > > find that
> > > out than have people avoid running reviews locally over a cost
> > > that does
> > > not apply to them.
> > >=20
> >=20
> > Hi Shardul,
> >=20
> > Thanks for your reply.
> >=20
> > Sorry for the delayed reply; work has kept me busy lately so I
> > haven=E2=80=99t had much
> > time to check emails. Please also excuse my English =E2=80=94 I might h=
ave
> > caused some
> > confusion earlier. I'm using the API key and noticed the cost.
> >=20
> > I=E2=80=99d like to share my experience with an API-key Sashiko deploym=
ent,
> > which may help
> > folks on this list use Sashiko at lower cost.
> >=20
> > I run Sashiko using Minimax as the LLM. Minimax offers a monthly
> > subscription plan
> > and is quite affordable. (I submitted a small PR to Sashiko to fix
> > some issues
> > I encountered while using it.)
> >=20
> > One observation: reviewing large patch series via the web interface
> > can burn through
> > the 5-hour quota very quickly. In contrast, using `sashiko-cli`
> > from the command line
> > seems to cut token consumption significantly, this is from my
> > practical testing.
> >=20
> > I also tried GLM, which is another fixed-quota subscription model
> > and relatively
> > more expensive. While its quality is not as good as Gemini or Opus,
> > it still works
> > well for local code iteration.
> >=20
> > I=E2=80=99m still relatively new to working with AI tools. If you have =
any
> > approaches to save tokens,
> > would you mind sharing them on this thread?
>=20
> Did you install Semcode [1]?
>=20
> I remember that this tool was recommended to people using Chris
> Mason's
> Review Prompts [2], and Sashiko use them [3].
>=20
> (I tried to use Semcode manually, but I didn't get along with it,
> maybe
> I should retry, or maybe it is mostly made for agents?)
>=20

Not yet. From its README it is mainly meant to be used as an MCP server
by an agent, which may be why using it by hand did not work well. If I
try it with the review prompts, I will report what it saves.

> It looks like this tool can save tokens (don't ask me how/how much)
> with
> the review prompt [2]. Maybe with Sashiko as well? (If yes, Sashiko's
> README should mention it as well.)
>=20
> One last thing, Shardul, I noticed the "/kreview" you mentioned is
> something from the review prompts [2]. Perhaps it is not running
> everything from Sashiko, just a part of it?

Yes, you are right. /kreview comes from the review prompts, which
Sashiko vendors, and it runs them in a single Claude Code session. None
of Sashiko's staged pipeline runs, so it is cheaper because it does
less, not a cheaper route to the same review. I should have been
clearer about that.

>=20
> [1] https://github.com/facebookexperimental/semcode
> [2] https://github.com/masoncl/review-prompts
> [3] https://github.com/sashiko-dev/sashiko#prompts
>=20
> Cheers,
> Matt

Thanks,
Shardul
