Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE9127E28
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536506; cv=none; b=aXA4GpZ58dgR/es0HPVpMfVnEE5lv6VJGIyUvDo+L2r3SBA1bdVUE1/LCKyCqdeWA92se8tS4qbMJaeFnCdboflhBI7qpeWCYUwcxRRLhGf5HKKfl9jbOzmpKhpLW9pWXyFaeea26ooWExxXOkrF3an1flAJvwpKZMGxE8S6NOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536506; c=relaxed/simple;
	bh=wArsTG0I4uUHt6kpqI5w+oWPb8mFPRNrXUS1jbipfWY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QHQBfYq71YTaO4iWslJjJIkHNb9H4F4x679W4h6rZDs4+/VYuq89eyJCuIemoYCgaA6vgAIADx7ONMYyghOOix4qFWtF1yENhxJtg2NeksxH/1AAlsRV1DjEpgREuwGFv7sbdI/uQLw7g3V4rh7GooSWWS8CyFxbbhNePRW0b5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EARs4MbW; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EARs4MbW"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-804ca9cf0f6so213538241.2
        for <mptcp@lists.linux.dev>; Fri, 24 May 2024 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716536504; x=1717141304; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuKErhzusUGf1lhPvLF8MhTmNHO1QcHHGcEEt6m1aRA=;
        b=EARs4MbW0U7LSFqCY/UQehN8Xe3lyfE8GiWjzDrKsCEfbJiF7vA3FHr6TDoN4sapbz
         9lUp31J5eBRuzLzHl+VWnrF9yBmGHylk4VPY1MxtXNxPEM0mdEXZCPl7Wc3xMjcqFFXT
         FtgTCz9krtDZbp0avBMsA6ZvtHqcqqrFeLCBBfZ0H5h6FLUhNOuruZu2B8pCVOwCmEiD
         Ft+QgAasT+B1O4codPfKVhV+0vuTkFBwgp9T6wbf9oOnYAtQ4HyrFINVnXM4vR9O08OM
         d2Jc0ELI4BeCFrbbECZbY2J50pqqfk50GBa7+ilnRSiHGZ4opGgEtf+Lb5SAuK+hnVQi
         9w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536504; x=1717141304;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuKErhzusUGf1lhPvLF8MhTmNHO1QcHHGcEEt6m1aRA=;
        b=evNEiKUJDLYGP3XcTzFhRjnLHNcaRDzVkOM/vxo2dls+sT6KGlR2GuYIx5zIJkzVaI
         ttTkzi9VzRPjTYpJ5PMbm6DjeF8irRRkg/41SlmOxePx7hAaLfjAgfRt3VKYHqPIwEVu
         mpVG26dhqJCpueOw/uIfo51HOQLZxlnue2jDKh5CGdq0QTS7aLh9JTNl1tcHBSJ+kvAL
         qkcQjYmcly2q7rtxaqsXuGEhZTSYl6uGE7QD+QEBZATQpvA+jZdQ4V3MJ7nKTQAgBr8a
         ny/GBfoLxL0OdrFW1gLALM3sDZLlqecEU0oeTMUsjsoP6s7iE9cJCQCVdkxX47FNpzaF
         xHyw==
X-Gm-Message-State: AOJu0Yx+tbaXzjigC78svyWP8ujKqcRfy/ZWYMOZMTmxZ5MXGG2LSDlB
	wTVRWQRBwE403iPNedqD7kfTlHsYZUckrcjuQNMLh77axENY1Wp9jFNx
X-Google-Smtp-Source: AGHT+IGnwVmONJd1MLipkTRtkzVdQfbXX6s3PO9cGNEo1NaEnH3fMTJIaYPj6+DHcEitYAEUuQkFtw==
X-Received: by 2002:a05:6102:1942:b0:47c:37e4:9143 with SMTP id ada2fe7eead31-48a38541e92mr1727240137.11.1716536503951;
        Fri, 24 May 2024 00:41:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.46.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16bedd2sm5281651cf.7.2024.05.24.00.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:41:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/6] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <1fff7aea-09e7-2f53-f18c-58a28eb4eac0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 May 2024 07:41:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all):=
 Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/9220006386

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e3fb24f4f6=
51
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D855590


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
