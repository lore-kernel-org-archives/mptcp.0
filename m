Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C84428470
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785855; cv=none; b=JqrUc1YETkjZTzDXT4YOsdXXuKYcw0Ef0tHPq1ntDKhMGPps6GfqZs/W5d4e8lz+lcLiF8AhTt4qBwMJncageJN7ktJdLBucCpoIZCkSe6dBlBJFjJPdT3YtjlaCIJxrTTPbgZ7HGZjrEe8+UiAXMYwRtkpum0dGhaVYfxRyCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785855; c=relaxed/simple;
	bh=16eZUWqzIEBbrW2aEpYMfkwXhFRiLhxQWs7/OQgsCIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4xafOVKMjOE1RB9gqB2qS1BazwwShOb1ZZPGjyuwK1zuLCCjEL8e7pJEsOpNl98oyqQ2ojSLlLNi9xdSBtR1apwcOAX0uECYPxhX2Rg40uzXtVs7M2of1fDSOCqNE3Zv3aTGYmsYZxXxSaTYU5AXYhDNpn6xnccXOF11vhjhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1T91StY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1T91StY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3211756a91.2
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788785844; x=1789390644; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=16eZUWqzIEBbrW2aEpYMfkwXhFRiLhxQWs7/OQgsCIk=;
        b=c1T91StYpiRNx0Mf7n7DenVqKcHWrVyx4A5eqVztNlF4R5yKxOs9BTlnRqqWnsMz6A
         3Gb5PWBh65vp6azIHyp3pBUi+7TWz17glAWgVwFZTrv/fefVJVYGBC+pvScW9Qq295Ee
         PWv77mtP8yFVHmoTZ6iUMOmc0p8Viaw0Dc1Pc332Qx3uotaQX+7iKYn6AzehOi1VBLx+
         q68evMdWYhJCRI4fxGwI219JaKKIHZiQLRRbmjEEqXSpWZPn5fY+gRA5kx3O95Lpa7oP
         6E/mn+6fqc2fhAw3opl/8pv0/a6L/GdHiwbkOHL1iMADNp2DtkHfsUXR2Kv2wEFPMvvJ
         /nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785844; x=1789390644;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16eZUWqzIEBbrW2aEpYMfkwXhFRiLhxQWs7/OQgsCIk=;
        b=qX8Xt+myM1P02iQDZJQb+6vonIoN1QjmQaLFK5tHl64UccUZi7nf8xzh4TQv+8UYHQ
         cEGR3IkrKMrdk8Fw4fKxkN0SIknemg/PRKGfsKALd21lSf+d73LvxlLn5zKX/otFzEzw
         OgBRMeAcLhnknieJsS0zGK3xpm+OJiQCUzqK3Mnkyi+kEPhb9hUCPdSlMmxtNCltHTJm
         r6kHURSXZdZzqD/VEj4eW0S1jPMnPuTwSxAItekxxCxFU1MVKn0AVyJsnbOyGdtoDXuE
         H8ZXez8Ib6uf53coI67kZRe6kzG7W6RdUADoL8mGWOyrlAbEmNpVyxL/LmfRJn7SYrZ4
         Uv4A==
X-Gm-Message-State: AFuF++m9aA2k2AAdaHtv1cYhJ75bTxdMlg2xweneB5mXQJYbYXACguKz
	09V60xvJ88+BIvP1D3KkZwQNNSojYxBNIg33Qo9qzSxFGHd5q3ZqVnDFa/GO/9nX
X-Gm-Gg: AYBFou1ltNGM2NeSXaUevD23Y7YHXXuvf5Hy0QDhTVa7m+kFJS6GQ1+GNcK70ueNXX2
	r4j+TTnOGatVcN1IV88WG9MQQIvX/K10WupSlCRGIPtH7JTT1GuijrQaDlFMc0HxcDWPK+wfN4h
	HPzxde/w6jA8yh9MyTfqmtWp9ChXAiuCHVMoupJ2Ms0yz//SIymFtoaW72TaZZZ0zCvvqmka9qz
	H2QqT3tJPeTpQ4mjvS86juxttj4Hy0i55rII7QodXjuVW6LtRq3Q0qddvYFZLUwRhQeMkKppeP5
	ZfYbdUEyleOG0pwmviYoDZXtNtgQrGbMbrYrquYuZebGGO4t493cbXWLX+WsiX0Zg6ndvi3cmsi
	Ea9TbpJerC3u/e+yW48U77lr4Cs4OQ65SchX3GUtgUln8ktmUed7NS81IEiWEPv/fBuRLmD+KHk
	QtXy/Kybh3EZhLAyppyy2B12xyoi8s4NpkQL1LURVygj7xtPSDleEr6/jrhxELyc1uMgvwFT4c4
	NLz2/qZrh14ebTy9nP3l5/cwRph3g==
X-Received: by 2002:a17:90b:1b06:b0:398:9be9:ab8e with SMTP id 98e67ed59e1d1-39b2622ba26mr32547169a91.19.1788785843474;
        Mon, 07 Sep 2026 05:57:23 -0700 (PDT)
Received: from localhost ([223.233.81.118])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm32378856c88.5.2026.09.07.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:57:22 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	gang.yan@linux.dev,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	kalpan.jani@mpiricsoftware.com
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main MPTCP list
Date: Mon,  7 Sep 2026 18:27:20 +0530
Message-Id: <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev> <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org> <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev> <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Matt, Gang,

On 04/09/2026 12:32, Matthieu Baerts wrote:
> So at the end, it seems like a good thing to have access to various
> models to cross checks the reviews.

Agreed, and that is where I ran into something worth passing on. If the
plan is for people to run reviews locally, and more than one model at
that, then what a local run costs decides whether anyone actually keeps
doing it.

I ran Sashiko locally against my Claude subscription, using the Claude
Code CLI provider rather than an API key. One patch took about 45
minutes and consumed essentially a whole usage window. That window is
five hours, so it works out at roughly one patch per window on that
setup, which was enough to have me scheduling runs around the reset
rather than just running them when I wanted a review. That timing was in
August, on a build from before the declarative workflow engine landed,
so I cannot say the 45 minutes still holds. What has not changed is the
shape of it: the CLI provider still starts a separate claude process per
stage, with no session carried between them, so the context is built and
sent again for each one.

The part I did not know at the time is that there are two quite
different things here. "sashiko init" then "sashiko review" runs the
full staged pipeline, one process per stage, and that is the expensive
one. The Sashiko repository also ships, in the prompt bundle it vendors,
a /kreview command that runs the review as a single Claude Code session,
so the context is read once instead of once per stage.

/kreview is not mentioned in Sashiko's README, its maintainers guide, or
anything under docs/. It is documented only in
third_party/prompts/README.md, inside the vendored copy of the review
prompts, with the command itself in
third_party/prompts/kernel/slash-commands/kreview.md. So anyone
following the setup instructions gets the expensive path and has no
particular reason to learn the other one exists. That seems worth fixing
if the goal is more people running checks before they post.

A few of the things that make a local run costlier than it needs to be
look fixable, and I have sent patches for them to the Sashiko project
rather than describe them here, since that is where they belong. One is
worth a line because of where it does and does not apply: Sashiko can
cache model responses so a repeated request is answered from disk rather
than sent again, but that setting has no effect on the local path, so
retrying a failed run pays for everything a second time. The reviews you
see arriving on this list are unaffected, since the daemon that posts
them does use the cache.

One other thing, unrelated to cost and possibly of wider interest. Of
the findings Sashiko has published for this list, the ones it marks as
pre-existing are graded higher than the ones it attributes to the patch
under review. Roughly 95 percent of the pre-existing ones are High or
Critical and not one is Low, against roughly half for the findings
attributed to the patch. I had been treating "this was already broken"
as a reason to downgrade, and that is not how the tool treats it. The
reasoning holds up, since a pre-existing bug is live in the shipping
kernel while one introduced by a patch under review will most likely be
caught before it merges.

Gang, you mentioned deploying Sashiko locally. Did you see anything like
the same cost, and what were you running it against? If this turns out
to be particular to a fixed-quota subscription, I would rather find that
out than have people avoid running reviews locally over a cost that does
not apply to them.

Thanks,
Shardul
