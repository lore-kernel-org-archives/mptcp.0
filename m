Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A749DBB9
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436899; cv=none; b=FZ4NV83wfMbB7+xBBdfeKeN8P06qFQ03yJBHF1DUcBvnKLzXvRXNQpJ5Ze2rpZsI9lKdnq56ybFwY5uXYqG9Fz4yiAASjxQS2ZGBh13tWueR+v+9+MWS0YK++sB8xjEnE5Q7SAY3u/D6Ni8kIS6iPL6NsE6emoE7R3XV7SO6hb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436899; c=relaxed/simple;
	bh=L762vH9zD7vMdunNbHy6qNeh1BjDntlW8rRn7czr+GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=pMJddOdWwC5KLiT8+V6dQcYFK7NqbfADE72ZQ1XE/Fkmt0HMG8A0eri7gEIWcgv9Zxphdzxhpw665v1I8IuZ16r8V9wXI6528dnYHV79MRvRYFakWQ9qCRdRtbubrWTQE4wo0U19u04B1en56OxtnQgNHUwrmRNxqWuqQ5uavII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyG1NHK/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyG1NHK/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52eaeddc837so18501441cf.2
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436897; x=1789041697; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dT9KOvzTCfusRCLmh9trQhQcvWc/w/AcB+g0zVN4XxQ=;
        b=oyG1NHK/lUb9qsjlcsR4nfbn0hHA7diyesdxv/xKqD/hODQVW8I+Qp9JYB+zRMpQ2A
         D6R6HyKd8bxerM2GYPQgRQJvo6DA0ymNEN7znjWbyJx/OrgSsMlPvZVxTZQxM60PYzhl
         nCTH4eEdF2c2ZWDKq82tyV7rvAVaw+lGqM1ICbOjK39vVO14kMo/xdK8MNP9KxP/nqeA
         lW+9VKyifodu88wSxZAet7p+MtUZ34arMOc2T/1oLr2X7/GIX2inkHYfiHcEzozBpohn
         /zbOx6botAx8M3VzmSVew22pLYwg3AyPo7oLwMHL/WjPP9F7EZgGBDmlH+DHVHZOgWkk
         MIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436897; x=1789041697;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dT9KOvzTCfusRCLmh9trQhQcvWc/w/AcB+g0zVN4XxQ=;
        b=aPsytsPqR1r5waNlKfT+kWbzKUtbXJJMdwHdMzquhGmXSv2Zl9MhHFHUSlOtWZ8Fmj
         N272mI9VhdmjLYHjqbWHk/izTO6HGs9QTNkEFJ3pK3FmJEaa3Ukc5X1LpHe0XlGzD6wi
         RLHNvzDhPoYOyxhjReSdfXW1zSDLxP+gyozt9bpJVUxMMWw+JYZsatk1tASsRtw1uH1p
         IhvLhAJxzNuRKlj2MeAvoVyp0AfJLkkjhr7xJcJORmuEgSFB828T3eKJhgZhSIazsbiB
         xyifxPKhyYAmCP6VBSJgTGaoKAH3sHC5UBgDOLYT8pQ2ABE7b+aZWQ0jYkBnLBHcnk5x
         yjJQ==
X-Gm-Message-State: AFuF++l6CgJlnZQiTeM/ohY+iLXxxLDcYNiZYQ2hBQl9vYThJTJbamnF
	AZJadqnLGAk4unLU1q065UugLZt9AypxSZsX4KBSyw13rNKereGU1gcexYDCPTk=
X-Gm-Gg: AYBFou20nNuf6pPLRfeBhfDRN9sYYlmExH5bnG/0IlTBi8B4Wu9yf5SF9xpZR6onxky
	2f7eoPzuswzs/6pxxrnO0t5fDPLOEM23owD1hoDme29uL7/ax1wQDW8RTMKqLMhTgdG2fXvAtKy
	1VkCGhogk6NYMWyshcywQcuGauiS2/5oThfA4paHGX+Ah9X+FZaRld958+g5KLxQHOVa7k6SpB9
	cOPJDUaWgLLowMwlnojTgli6q2Ll46pKWAQ4bl8akr9X/QMGBGjNIw9CGY62SYaQ2A7dfbSrpVx
	nMMLXU+NAw3rtGCkf7PVRO+Fec6/2dFtR7FyQbtVyZUh5Sb8DzgVtj0+eT4uGK5OgtQSV2ABIOM
	Ie/MTylWlvg5vvEa+PDTgcCQ+e1pq0lQRw3wGU3wTcvGme8J23xGvc/iQZjC9rRUOq2uanxNNLE
	7RD0XbN24KD0SZH2MFkfaqUzlf/DUXYFb73q3x+KWo7MDn3yAz0cFApGn3aFoYNJJNZUjTKI43V
	Sw9
X-Received: by 2002:a05:620a:5eca:b0:938:e95e:9377 with SMTP id af79cd13be357-9396e07bbfemr518882385a.30.1788436894156;
        Thu, 03 Sep 2026 05:01:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.205.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395ef95945sm482426785a.0.2026.09.03.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:01:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903105515.906187-1-kalpan.jani@mpiricsoftware.com>
References: <20260903105515.906187-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v5] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <c5c1c074-deeb-980c-758a-ed4aae671d87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:01:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33748666442

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e18ff27ebcdc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157000


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
