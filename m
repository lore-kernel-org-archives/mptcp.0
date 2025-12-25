Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54E23EA83
	for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657354; cv=none; b=VcK5Pg38+HCiGqact0+GoJdWAdZU4D8Nh8iKsXPuscQO8bGHna6s2oqXRIhwanngp1LHN7hvqyYfNlWrFuwmV+8lviNkAAY1HT1aPk8mezc2o5/uFjge5ghNLt2XgzC/1eYw/uojRbTwII7hyAvug64bhDrywtfTsnHz3olTXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657354; c=relaxed/simple;
	bh=3p96LzLR0KdfgPRbEHsdBoNKEswQbmYBQ7Z9KrUYHRs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aW1g8i412yLu9ZJwipEXVUAP8mY8hnwrg5Hp8dQ4je4bxHvA8Y2FlyZBSyfWKbMkHQYAFHR8Asolkq8uk2UyvwCmijkIZgj98Vzyyaxki96LkoFVfjcvHPP/QVdsQDuQhDSGgs19j1D2LsyyIbk0e7NEVzCRjiZ2kS6WVuC7rMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPdccrYB; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPdccrYB"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2148ca40eso1016801885a.1
        for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 02:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657352; x=1767262152; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0c4W6V3W4pX1eA/bpwACCDZpaBBrOymqsoGs+AR+ts=;
        b=TPdccrYBVOQb/Un6l23zA1elS8FPhI+CrUQf4bh5Hp3IyYR662/gY5ecwtp6hF//Vq
         K7K+tyn/HB2xp26oqFu/y32OC6HC5E5Kz3dsQhGafNB5j/ehtDSCcIgApcfSPSdrh4Xh
         acstjmlvSVhMkJJNhKPSNeGDi++d1WjH2fdjDvkKN33BhVx8uzlFCDAStnMD4pbc0QSD
         stHX0UExHcCnHaKNNbPKksNOHQtOSMTGz4nxMszXl9N4VhebaMZ8DvUF3e1zYenAmnt+
         JR1HmslkM1iKNoVZ5bCa9irLJg19l+FohpOCOa4j6hrnfeME1FfR8DvqsxQZKf+/jVKm
         4Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657352; x=1767262152;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0c4W6V3W4pX1eA/bpwACCDZpaBBrOymqsoGs+AR+ts=;
        b=mtt3Go4BnwFhltmqtSv5FVIMSP2T4vEJWYKXxRhHfpxJdmGlH9YBgvwN4f76lSSpvt
         ScJdJ3IQiAKmF4Qa6RVeSq5gGtSW0c7w+MzO6Gmn3TatFcw2Mihd4mmITeTGhK/SwGJk
         6lCg8O/GiA3CTcr0q/Wa1An2CVgzjF9uYLyRPSxVaPb3YV5zoe4M2DkIzjJ10FJk8rWw
         WYbzb4ifTQn1Ox3m05KxC5Q9AF7u3XiMHqtaDwCpjRKw+MvhSd1AoWdFw9bxorxkZR2b
         WSoZqqpEYwsMqHYAayqwYpv1lWjuDINayC751hdf0VPgiHPGUrmEDVmTj5UfmWkBGFIM
         aB0A==
X-Gm-Message-State: AOJu0Yw1QDKCIX0suJcG5LMTIRQ4QrEFT1vvJ/C9I945c1GMODdKEUrZ
	Ee/5Xp+Y3kAa/QqlMwrxuCKhYO1pjZ0o0KBp8w+FrEj8253WvLddiI5Btl4HVSs=
X-Gm-Gg: AY/fxX6K4d3RmauAj4Kz7HOlAjja4redI7yfi6N0lpdB/icIMwl3jjN1g/ePPgjaFHO
	7jiXP2TYz+rA9dZ9f46UW25vnr1Yjwptv6/wtkjyoJ+F9oOHc8zSh7EtEDrSrsgejz7nZmEZN6Z
	CAnaz/HMelyOWqb7WoK03rC71BtDapLCV2+AeQsgbyqwhhyjA3/JJddEonsR4DjCHr0goDqAAVd
	1jXaMBVp9HotQ8AUtD/yPgsrwMLop+aDz3USRV3bEHXL05TOI/5558jJiwR59YD7yYjsN2nFhTg
	DVANWju/1QYD4BJQVtQFrVkBR5vi7+ugajk3HTSh1QuHsgKBcCrCIzdHKGw5wLCu9asjH5eRaUQ
	NHtbXMufxBF6hQkouoOivEPKeqeuF1rtPSG+Z9DtTyRovpJoDr5p20O5/eokO94yQnnl05V7Cpf
	asWEQNWEL/F4Ci0xLp5V5SpBU=
X-Google-Smtp-Source: AGHT+IHjyvJmOK3wPSmcUkPD/Dt+E1u01jyE9Xj6zE5t6CkZJ3LzOu4mk0D/pwU6XnsGx2N+YMe9Jw==
X-Received: by 2002:a05:620a:1789:b0:8b2:e986:2704 with SMTP id af79cd13be357-8c08fa9be3fmr2775022185a.6.1766657351721;
        Thu, 25 Dec 2025 02:09:11 -0800 (PST)
Received: from [127.0.0.1] ([64.236.143.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fa6sm1493121585a.28.2025.12.25.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:09:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1766653030.git.tanggeliang@kylinos.cn>
References: <cover.1766653030.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] implement psock_update_sk_prot
Message-ID: <f6354273-4dde-668a-b450-3c1e18c7f058@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Dec 2025 10:09:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Critical: Global Timeout =
=E2=9D=8C
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20502612231

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/274e726fda82
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1036539


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
