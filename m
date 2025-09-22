Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323EC2FB
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758565106; cv=none; b=Ijoj2J6okXzdX4/rOiTUxCofKFDW1Xkdvjv9jaTtSJAF5TsMhwLWER0o3j0YWmymbREftGle9ppkuM8CMXabPPhRa1BgbnHpN0wF9tG3x7/ERYlwz8h81iHDKQGETeOnPC8mAY+1xVDvrFyUZhcz0ezKEflaQenno8R2pi+Wbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758565106; c=relaxed/simple;
	bh=6l32AbAF4lZFcnD4Jduj8iNRlmOa968Kw9aUaPKOFIo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=n7Dt5tF6zxd6lYs8Bo6gdLVfyjPlqO/qj55WUZPQhpRoCjT01DqOaP+KBIubggom0M+QjuxYT7903P7IVkDyxpWHc7NPlwIWl7pnvzNfaypGjs4qce/EICDYNpqvM+yRlP5CT8eyD6vstvQlIFV/6oOVzj73sBa8XPJL+LD1SqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWyjkyka; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWyjkyka"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-425715aeccdso10125145ab.2
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758565104; x=1759169904; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxUv42t7pha8EUeOYIhtqq4aVK+LVg6RKr1L24Jc6O0=;
        b=PWyjkykanuBYGWkeEcJ+W/O0FTfZz0I+C5sBqe408OfaNz+smudl4OPKtz9IeR2SJ9
         mrK+g5AWE3QjVByuOJCDG3MomzcvcKY7jgzU2Rawd3qfqL2ducoPDPg7mt2VsYHJCyM7
         HXJODX57oC98E4dosJrcMg7Ly8VMbdBW/izw193Y8TOzoaAo9G+X5OmctGQ+qA6ecAZ+
         eA6iUNJXM4MAVupIJkG8bxejw7wHQtCfm0//27dnmAnCNNNm8zK/tY5kWm70q/QMfqs1
         nGla6HUjXwMEChE2LQuG/u0ZHZHbLKvJuxRmLLRS3bEGWMjxwrSvPBoi/KWQGBix0rZy
         tdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758565104; x=1759169904;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxUv42t7pha8EUeOYIhtqq4aVK+LVg6RKr1L24Jc6O0=;
        b=qNOSThPqwpVYaDTAGvdLedXssSeJzaBnJ4l9kc5h3BNsBS05X4Hyh+t5trv49RAm4C
         TG4y+rosNYoD6jRQQWixRBtIr9Wb5LWO6Fd4RiEor2FLofKNLnpKrvVvnmCp6/osS7uT
         R5uV4Mnya904XrlyM+TixiG7xYmzylaW0bwqAK9AES1IBHaIbBkHTtAHwN6cPzEM4Ss6
         TmRy7hfMzei4Q87SFOKsuirfJY+ioaTrV/gTHO6uncXB+I7vTvNfYJnbbBDzDCdb7JAc
         aHU3g5DXe/kdlMps98vhLHkKsOrPsZY5ASDpq7O8deFSBpKTRoIKzfgk8M88CZqHjOs4
         C1lg==
X-Gm-Message-State: AOJu0YzzIlFsf3NsnBeRJ61yiDrTtw0CMoc8j/8Ou0lrpYKLrgI4/WOM
	YptGy8MZNFAxSvg3kJoxu/0ebHQQJCs6ny2WdW8N5QA3nm1bZQC1n64pzuch
X-Gm-Gg: ASbGncuexWDJ9s3QAm7k9OANlSEsJXXuVML1DXpO7AxR9OrOufJNB4a7hNxmAL9LXj/
	fQDtWpzrqFDFmW/sgSdY7fHNTDj4c21dfkndQWaxYsZ4Mf1rZ6bp1y4DJARUSeUK9d635+zmd6N
	4YFYtzVn+gN31vPL4Xxuzk4m23oy0rPstSsNhlIkvGXuSUz2eSmrHWqcq5OqJu2qlX7bLUHzC8C
	L1ZZr1XWe4HTp8d0LT2tRupT+q7e14b5GrViwu8UFYiN6TDJuONVn+BYp4c+dXNndmzFqYUGv6f
	Lrgz1Cx4L28RCgH1M5gKWq7/qHnTgF/gxEf7p7pQixy69dRhJkKFkol07vPUja6oszq6ubH2qdm
	G5jq1hR63W8iePa0uPT52JDiRhI8TL3T0Nujr6bvFvPoAmq8=
X-Google-Smtp-Source: AGHT+IG/LTQDBHFgT2si5Oi6N703nP+1ELE62mG5XaxTpcqa8v7ylWdsvehbomfSQfbqaClSqoYDQw==
X-Received: by 2002:a05:6e02:1c0a:b0:40d:e7d8:63fa with SMTP id e9e14a558f8ab-42481999d70mr180815065ab.26.1758565103812;
        Mon, 22 Sep 2025 11:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.131.105])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4257d3a98fesm9339505ab.32.2025.09.22.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:18:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758339666.git.tanggeliang@kylinos.cn>
References: <cover.1758339666.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_fixes_f?=
 =?UTF-8?Q?or_=22mptcp=3A_receive_path_improvement?= =?UTF-8?Q?=22_v3?=
Message-ID: <77453200-f128-234a-f44a-5cf5752d4d1c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2025 18:18:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17909424668

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/808fa7e15d01
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1004452


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
