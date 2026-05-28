Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9383438B9
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779943466; cv=none; b=LoIt/3+krYFp5voIq0lX+dBoS7u3MLfDZMTymHjo+RFwW03VDqyV8gb3UJbf7TS9rqwAeI3DzPEHdQpLLpWnfsTFpm0yS61uxdkEfI7iUo4Z9xzHFpi/tqj3MBlq38uQ2RWtztguOY3+HcZDS/QdQwZ9JpNXoZcdWo8LezYLTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779943466; c=relaxed/simple;
	bh=XGluCpOQl9GdVTihaDEwfhck8WbS4BawdcidBxdb0BI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=r7GVjUcd0mlztycp9V9VanBBhEs/JJ0vkDl0FlWkgonIBADlUIB1MqVumhJrB8Zs04Q/D4Q7MGjFxNWJ6kZOu4m49higEwx6Xwysi3o7g9azIfT1KgNUZX48/vamVW8DIjd6sJrAzCx3ma8vN5384R8R4dG75FxUGzNv764TwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddo3sE82; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddo3sE82"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-512f750d4b2so131751871cf.1
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779943464; x=1780548264; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+inKshtt6g4FAYpBd1DDEE100a2bGWURfA+HpwT+yJc=;
        b=Ddo3sE82sdGZweAuhd8+HnpKVxJedi0srTT/JooO5L7EK2eand3NtDpLAZ1gq7V74D
         mvhLTqGinfsrC4xAYozKQwgwTTX7XsBGC1mYj4VpYEbOQZwxkXEED33guDTagboBkqVt
         SCdhy0bSC1VX+3BO3DaVptOgbo2Uo28mRj4pywOkcczsjoWoaIvTjYBwgmpPflzJ7Nic
         GiKDrbwM9vP18lDpuGZJNSn4+aKqHUspWLXzKoo4+PZDFa4AKTNnd0SJ92kU3Z/mCgaw
         B95EqRhC6xwkVts0KwUzvW5UTotrHGBFBqFt+O8Kvg5T7GjgSdxwa1jd3YENb/lPTDzT
         P3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779943464; x=1780548264;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+inKshtt6g4FAYpBd1DDEE100a2bGWURfA+HpwT+yJc=;
        b=RDenhKW/eJZKNRSJWEjA70ed2w7+F+ff8aqS+ybwrM3Ww4X9YCjJuWZXBPIF+878S/
         doc1cLKvTHdeI4dNwU2IgcQj5VUW9GSJ3ehVleke5/22cnejbqSCOaMIeqdFuQTiwQmA
         8NBu67Y3WXxj+OR+GyuAsK87RmaywyfEnV7Pjj8DZ8POdAQgn0vH7+4JjruRdvSIgHMX
         oZhlKRfGTN/7vN1Os8Arby11mvmIxfih+Yh/ni0HtpYhgNYmWUwUuYB7rJ3k9v18caox
         00zzR09SiFoYaPd8d/rNpSJgCPjFc7rAni26D6oKu1pgAweoux9S+Q3xWbtwgMbqjpox
         51mQ==
X-Gm-Message-State: AOJu0Yzy4O9qKQV55B4irjNkji+cEZXa5HA8itpvCgJJDmMZulcWjfGx
	KhPlklOdnSTGxHdRGJilQP2/cQaoEeAhoYHfWVDIDmqRv+83mHkNDY0z+2f2
X-Gm-Gg: Acq92OHBl6vZ5XpgcSEbzuBBQ9QvBuhvbDHkzALIVGgt4yPac1Vf2/jqfEBkHLgphlm
	amU6w5Rs9Ra3nx94ysGOIOoVCSGGxvMOd+guEQQu703+Z8xFkgHJU/ohjG/Kj+kzGYdnxxsDnBw
	zMciVdZny8ot9KNR18nAoFxZNe0IrfU/V3nCaSBiadRakSBOk+oeilYDbunTPTeA7eS5TCfTroz
	t7vu0G8Cv7rjqMrbz2dZs9bhJOmuJ8iCnrUW4hRJ2ubCI3aTiRzk6SWf8zZl46HPf1KJvf6vdkQ
	FFsmNtfeRiFIfr3PKNyxeEsMBPMj0b5JRapuGlZJdOa1TGfGneE5rLJuGFYpcYaAaGfy8jyiczz
	ryDCKoBaJdb5CKBdhRD1CvNR1321O5FAkjrnS/jptq3JQXRhQ9S7c3giOSxYsFY9zbXOPqftuVZ
	9ZycSJzoU1jXwTVbBsXWBlXsDilqcCIqM31fS5XZMYw9UcMweQJeq836YuJQ0=
X-Received: by 2002:a05:622a:5811:b0:50e:6313:6e13 with SMTP id d75a77b69052e-516d42857f2mr364491961cf.5.1779943463587;
        Wed, 27 May 2026 21:44:23 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170691af70sm69603201cf.0.2026.05.27.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 21:44:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH 00/11] NVMe over MPTCP
Message-ID: <99151bc5-1776-527b-aefc-b802a05364fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 04:44:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/265530=
78551

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9301d8ce78ac
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1101939


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
