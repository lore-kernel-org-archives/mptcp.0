Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3263A
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324336; cv=none; b=XXvJNSaPv8dCA4gjqP1nfk1uy23ip1UqwOAJRR3jY0xpwnkn5HtSNebNl7SyM7m3xZa2lvqnOneTce6YwPZ+qwxKMSjUQWgeWX3Is0jTl7v2fxxfG3yifg2HgOABhdAuEVKhqmQC+DjhbnL08vq0CmF0IYP0yA0OPeaqlyqoR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324336; c=relaxed/simple;
	bh=pX/iA4JppMxHBXV3st4kAgkYWvUFNFpOYoAmzayajKw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iIJpP3MFlG0ubky2nUMX/9A+rdLUphd7MqoUfom9EZYF6okRvoEXYJqmOFrtD9MpomUoFvwh3s5k/9qWfC2XUDKj9RNKZA4dhOjzRnz1zD31CVRg+hT1sgaeQ8IBMKRmuAcawZhDkk06qRnitdiLqFmD91BGasjdE212Szldl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekS+5ktI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekS+5ktI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d62c1e82bso343106585a.3
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713324333; x=1713929133; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa6yls8Yuab6GXSUBYPWA+B6c3jtQ0CJjcRkzB23jGk=;
        b=ekS+5ktIJN/gZrFNKYhZPg+tjq4GnL5u83eivsz05oLkfuAosrtVkJZC1m94fNbaOE
         +mY5DsDsVuocxzUvgn4Hcm0MMVJv1AMB8FzxAKL2Jo9JJ6QOKSTHfXoYHAdrKCaZjDmw
         KCmmI4xQXwN7pSDuxDW7pW78mCxDiPskJF+vFi/p6mST9z/veagqQTBKzKMpTWaXqy8a
         udIpOB5uJ31zExtYGLeHS9TeZGjD7+ojYg6yYzTvAf/TWn5jeWyoKxRyF6P5+cfnMw58
         6Hc3GXMF9GPbhu2I0lmJH12EOO0SPcBOFray1gqr0jKQpRwpBuq27mxtwGcqYqqyyNtj
         NaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713324333; x=1713929133;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xa6yls8Yuab6GXSUBYPWA+B6c3jtQ0CJjcRkzB23jGk=;
        b=oM3g3ymoyinkrOWcfgreRrtsmf4m+S8GOfalTORhBOJy1OLZOWfCEGrHJMM1jFs7Sw
         0qauTKAIi9wZ5+0YOM+UJk0rFUzjHPQs5cYRLhO5gx5zN+UPfLed55SujpXoH1NYFGk1
         j/Xk/TcIj8vkKfTzPIxYixvFsWrFKKCAZfK1Osne1HQ3vHVned8UlLsHHF37/RwQyKuP
         DxzyurNmNNHQA+FNPu2FXgQYEqCef8YebfkqFBqPbpqt26mhLDUBZNefPJZwC23fmtIb
         hMGbSvUICarXPveQLe7pVT36rqJ7Oq6mCPJikuKQ0C7uDu0muBRToKTKlftRThL5fnG/
         O+eQ==
X-Gm-Message-State: AOJu0YwzAAFAJJnlnXuck+oJFjPK/ImoyZ8eb9qaykIGe86MfhASOMiU
	n6/GZwZWncj8Qig7i3qMrwcN+OAYZWK7t4s78l1nuV40CSP0dCqt5ZBa
X-Google-Smtp-Source: AGHT+IEqNObiUOg0Hqs3+D+S5piREyLtmdSuw+EicVH+Sd0esUlU71kveyde1WzOtaTqDElEY88tzg==
X-Received: by 2002:a05:620a:1022:b0:78d:6574:8230 with SMTP id a2-20020a05620a102200b0078d65748230mr15447202qkk.56.1713324333488;
        Tue, 16 Apr 2024 20:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.119.1])
        by smtp.gmail.com with ESMTPSA id da2-20020a05620a360200b0078d74f1d3c8sm8046904qkb.110.2024.04.16.20.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:25:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/8] refactor mptcp bpf tests
Message-ID: <5def3f9f-0654-3faf-2669-0ea48bc183d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2024 03:25:32 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8715586777

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e8e20b6cee14
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845257


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
