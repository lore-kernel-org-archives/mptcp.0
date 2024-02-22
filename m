Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9F10F1
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576293; cv=none; b=rCuCWAfZy/SaoduleHk6bmiOxykNdZC070aGi1BeVxptTSZ73nv4NVcgMKh3gTZk8m63pdoz4AoCb8vMQas41b+3O60skgdQiY1zOPAaVm7dWJCjpfvhecscEFk7onb36/8KMEFfbkm5BuObOyxENq5YqlrjSe+Y5Bx7T62M3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576293; c=relaxed/simple;
	bh=K8tMMNYeymb9S9CjIExhAASp5/77pglkIIvT0tjcTqI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hJqXU4osYMrrPZNqQi6RWZk/5MY9CbFjKYrvSHC1rl2GuTE54nGYm8rWGtmdPR4Prju3H/zjy/+YWRaSY0TilgYY/GZwZQTnQTPIuYvNU8VaWbHz5M1mu7Jufu1Rj0R3kXxw2Nl8mnDyr59W6i/w8wJenbpBlU4D69sYGHwJwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwc4Ko+t; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwc4Ko+t"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68009cb4669so35836156d6.1
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 20:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576290; x=1709181090; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvk9NrKk3IBeApTVtjnp4BkYxGB2WfGuhRFzh/C4Z3Q=;
        b=iwc4Ko+tX6C6vBidLmDjQvsvgipV92+colBUOwfs1VAf2nZMKAY3YkR4ZYshp+Tw4G
         eR9fEnJ7r7bqIppU93zGIanQrpKGD/I4a/OcWCjUhPJcbFKfX6sm/cfJvlVEjfTJKE4o
         KGutoBkGZ8yhQ4plAlJtkB9Vq+AD31dJM2fFlLEkAUkrxxqNt58Q8mq+DsGvVabiMEhh
         ZDSN8dymrWopSoSY+XU0UyEdi8ZDNikTeFJ7iTrjX+5/0D1QiIv5hp1M+Ur7uheDaWpU
         TeVjb00HXcSddB/afQE1FPOwG/ra1f3m/pqlvvDpmFJwrwMEnSCw9/EmNh1GSoSQIMzq
         5uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576290; x=1709181090;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvk9NrKk3IBeApTVtjnp4BkYxGB2WfGuhRFzh/C4Z3Q=;
        b=A9y3tUWX8HUfJx+XithdD5pGWOzMM4RKX5eDpwn9Q4nDm12AwsIQHUe6i8qMTgKoms
         KGXX76Vi//CEfHihV8uKhtc8IUvqIEdvz1zE/638huwingq2WAJyXKNuIoJp51/U+Gq8
         5G2AldBUHd/k6LyIZ9A1BFdgkXowoXPdZH9UpEfWKJzPCGFRJd8ANVH7I6/p5c4stDAm
         XF+q3rXdaPri3/CIrR4+6ysuMBdeDGOomI7S+pIX3v7EH2MipIiBr9UZg/3TIv8OG+nr
         fXvi4fkYEjoz+q+HFaG+9PFzZCNGv1aBvgsegQnC0mK8E8Tmxlo3Ffjd34ucTRRltyQn
         JXJA==
X-Gm-Message-State: AOJu0Yxqr7fOLticrk5LqqahXeFUwr/Y24OycjO012uy4rpJMdwlX4pM
	+udUkSuKopKbwYvGHsJ+EemtnI9XSecH439AH9VKInjgGGZk7Ho1VDUAZeo=
X-Google-Smtp-Source: AGHT+IHnNomxy1FDefeK9P7w/1cQUpG0s2hiEyypTJdSH7sH0UVWYiWWXEFwo9+0GQuldkdAO5Yhcg==
X-Received: by 2002:ad4:5aa7:0:b0:68f:52a9:3b24 with SMTP id u7-20020ad45aa7000000b0068f52a93b24mr14238828qvg.29.1708576290219;
        Wed, 21 Feb 2024 20:31:30 -0800 (PST)
Received: from [127.0.0.1] ([172.183.154.176])
        by smtp.gmail.com with ESMTPSA id pd2-20020a056214490200b0068cdbdb8af8sm6113012qvb.119.2024.02.21.20.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:31:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a306733bbc030878afda1ba501a94b40b92ec264.1708572320.git.tanggeliang@kylinos.cn>
References:
 <a306733bbc030878afda1ba501a94b40b92ec264.1708572320.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_events helper: Tests Results
Message-ID: <6e66369e-cbca-3de2-8629-abdf288e055b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 04:31:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7999199133

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/965ac86521bd


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
