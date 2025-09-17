Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6B31BC8B
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108060; cv=none; b=eW2uSFk/xjQrgxoTVmgjRLxP1MjwfcqDTeV9tDW1+U6hJ+swMpy5w3uxWneW7iAqtgDhUW/nHP9aLRu6D2rsnO1vrPfYQwKzAKrZhToRnb9rc9t6Zm09z8dfDDhcKdrUjIe8EoFr6F7qhGnEGRieqA2OZQVCz2+05flypk1dVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108060; c=relaxed/simple;
	bh=qU8MeUB/wD5/KM0UkzI/LsmyNjEYEfZ4mlWk00gX9dQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XCo8cH17Kz657updfBijeMmgZQwVzLp8k76q7cr+e6jP6gobhl42GHh/owLJxp69zLEK6kAKsWD5wAke46ffgO00j1hWDE9aPyoQdh7aW0tZRCiTqJ7xLHAwpqj1aOdgarR9UgLPag0KKcTb8aF88PDFflbUXloI7v9Pj0FE2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpI5ZlCV; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpI5ZlCV"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-417661ecbb1so72751005ab.2
        for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758108058; x=1758712858; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A/d+yoAXxE49vpWa37K0fM104ZFjEmQIRq1hg9UxJE=;
        b=BpI5ZlCVz5WPWTq1gmKan5ZFxS71+yBHVXjWY3XIhyU5jQiBjR7oI1kPovMTW3McJf
         tXvCRgn2pPInNvp/7HC2XVwRbH4OiEXSMaFVVUi5i8LUaPEDy49Fulm090xWsFjKOI3u
         qJfOe+vXIjrRDbfTQgkW+LqAzlamWL+7XH04Di0l+0SGLhC3Fts3FmwCuabHufoD/Oak
         yPfv60vGjFZyPyYrPEkiZGlYmB4qp+/2x7D1ePV2qT1C9LPgPBns6ElDSVW/GGnP2PcI
         nd1ZN2RM21k90fQI14zeqtvojZXnT1pf77VLZdA+azsD7GcURZInC5xyW/8XcrGFnMFi
         68vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758108058; x=1758712858;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/A/d+yoAXxE49vpWa37K0fM104ZFjEmQIRq1hg9UxJE=;
        b=JLOUSpuDvxQVL5F8hJJjslIn6clH48VUGi0GiqCIFGghoxTEYNoHXKWgBBV3B6w/Yf
         eVQkrZkwJ+TxuCo7AIS3ZZ6bCCPzRQob53Q3geOs3JT0UQxxktxCFJNFmWWkzRyA3pQN
         dD+DDOjT/72f3BOhsb11NOhNlvULWanGhFD+7N26f60hOYyK+60QGk4zr0YjtIOEH6J6
         z9f4pnaFjXArmlzVu9PYYNjqWBlWDJnTF9z33NyAPtBW99H5Bn2/zteKNmUs5mf3bD2C
         NOOzFwX9zBBvZHMNV6QCy18HILvD8LtOAfVBIApO7mHBzHrhUnoC1tcOYY2MvfwUpmaF
         3BAg==
X-Gm-Message-State: AOJu0YyDR8bqR4n/OC2YX8GRfXuO1kELZiYpUZ6LrtSgq8EZK3te6QVR
	LvRSuQsPpIaeeHVq3Q6B40kCdKxTWZ3PgqECQQ0YTdfnsHAh9NoLTsc=
X-Gm-Gg: ASbGncs+ypwFRVq5FaZJq+ICBpL8+oouz3QAdbKxC7KK/J04WJEfIOpNchMROHmTgfa
	nlZpHn1sjCDwJ/6sXY71haxE/7j0fV56ZH82Qpp7qoJJjMiqn46r3DVYn/X5Sdyf+KXLQy4llut
	MrboxZ+DMZz3k1MWaY2EHP21DUppdJnlXVtrojAnJ6YpKlNkOVsIsH8hui5P2xToBDeRvZbLkim
	OeiNzQL3YrYXq+7dbnR904n1S1s7636/0t70sTMiQZKn7Gg8lbANkNKpQfpx4/3JnACgjdc+vQI
	+sEq7uYG6nWv+z9MU7QbfUmlvCqi/qCvLFPmlD/w1aSWMkT8jY/rgDAGC2yKYDXX00ub5UcrpM/
	byswiT5cfb4b4wYxX8Slz0Re7pAV9pJFSPoo=
X-Google-Smtp-Source: AGHT+IH1uirlQn6kKypTnD1yLI6hHxJw29T9kZrxtfKl3OC/ZInSOJwO2suO+L2wo41oa7hAYCcFUg==
X-Received: by 2002:a05:6e02:1689:b0:424:9a5:85a6 with SMTP id e9e14a558f8ab-4241a564f73mr18478905ab.30.1758108057724;
        Wed, 17 Sep 2025 04:20:57 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f4500csm6860775173.31.2025.09.17.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:20:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Subject: Re: [MPTCP next 00/12] mptcp: receive path improvement
Message-ID: <fa724ca2-c73c-b9cf-6b3f-98e4105e9e43@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Sep 2025 11:20:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/17795536140

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/f83d2e5ccf99
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1002996

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
