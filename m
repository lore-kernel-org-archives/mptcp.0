Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C11E282D
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180808; cv=none; b=JATRUKG51zD2PtgDqBLcRd2KXHBwGH9aaYPbaaymwPWKM0BKTTfTSvbAafa9saCy/vtTf+wZOu7pVvswsE78gf7ZUaX4+GSGrfeRSBCtIIX9R3BCT1CbHS0NI/ci+gF/0pkWduN9KClB+WkWxpYeW37jocdNr3+inhhQb1TuKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180808; c=relaxed/simple;
	bh=ek3w9ducjx/I+wGO0ZMhv3ge4Na7bcwZDl4o1w1QaGY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sOkNi5Q2bo+V8pbMhtudD9AP2HSigpPXwQ/5PO1WxDdX+Opsp+Bs7rJYvAr4RFzdM9MO+/LLCcXO7vkVeVHOM9ixtFdby+iD1oQ6hSwThAPkgLPqKyvy6beIfKzPTCfZ7NUgiFrx/6SvI5z+SqWPjTYqSJtTzOku7PUZYu9nawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2OYBX3V; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2OYBX3V"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0a1c4780bso269642785a.3
        for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740180805; x=1740785605; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ExFApTpjOxS/eH/OyDbpPX1NNEfTUSdBoh5YfB6jJg=;
        b=F2OYBX3VzeDokq+sqL/XdKIDBUjF07B6vRWRVAj9LtBkjCb6cnnbBF87G1MpiyAFfB
         PnEWkEo7mPmroufhL0fZby0W0iPL90LdOulf/RWxl7KYqn/w2JkXoTDtH9f5jJdeGhX1
         2cG0k2ajUwJ0JwfRk+zXGzr1j5zyu/wqWcdUgsJK34lIhgojU0aVd7BGlhbzP1B4IlbU
         4894fBVT/KrKlsp4flEmrde9w2tZXtiZqj4rnLchQypg6Dahea7/3zsNMPgLGBhP+F1k
         QtCkhm+4frbwrHcmOXT/E2QME0PGEXSOc9t6KOdQJ5B8D110M0mu19yZhmGNaNdGn+9I
         Ilhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180805; x=1740785605;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ExFApTpjOxS/eH/OyDbpPX1NNEfTUSdBoh5YfB6jJg=;
        b=vw29bpkYbtcv774B5OQDrpDu1pGD691KY6i98XaTwn8VpK4rEE8BGVXhscA2F4FLS2
         E+flsuvlkkBix61RXtQViQV4C9D1AL3y9beFTeJPgtJRSvtOhbm0QDXQ/Gz5HNfevo+i
         WMAmJh0WGWhhiSv2tIuTviV99qlSMfXSApr9/Anuw5Fgm4l8rrz0chJI5k3cmS/wuUwr
         hoUEH++GTxh5LNU5Y/Ewq7RMaWeqF6rm9x8PmAlkeUIl2WvFoBrKcP3cXQ7CeBkLuttw
         qPu0bq3GbdcpO2doorZBXKhNghMANXGZXAXagvsVWhComVHjs9jV7kn1Yd5bdEB3Le3X
         girw==
X-Gm-Message-State: AOJu0YxQVQ4DqxbeKzHUVnQPUS4pKy77yrFb6o3RoEMdM4EMZ8gpegee
	YxsJ34uqAtNYhR7XAjxtL5sOP4WFEj+4S/RcasgvkgZHU3VhdLwSXmio
X-Gm-Gg: ASbGncvAm21w9iN429jIo1fByuCVpSU2DSkDi84MDqeKhb1OVud8gGy5Wlw+lP9lld3
	tCSSqQXCCHfnftSEaTconVYVLmnsZYHRtA7AFxTuyP94NXx6LlbfdH+hbrgGGNDW0XSxAWuZLBv
	t3Mc7ZOojhev59sCJk7PNJFiwNBm/qSh76i3M5QyRUJ3Vgbj9Wn82yuougEw4O/v/wWRdCJRu8x
	ck9v+XF33hL33wXQJHlwwQVQHnVijW9mBWClmFmYSH9Qze2O2mBNkfOakTfSCmvKI+HP6ym7u9L
	NVcQNLsvdrtz8AULfr4oIlcrcWltFbI1xXZJ3g==
X-Google-Smtp-Source: AGHT+IGkbH4cmPygjQWxXgNL9A9gpXqn+uU+Iz6iuXbZosf2b2XOff31hEVnk1pZhT5UtscwcyNUCw==
X-Received: by 2002:a05:620a:462c:b0:7c0:9ac5:7fbd with SMTP id af79cd13be357-7c0cedf4d77mr688780885a.0.1740180805676;
        Fri, 21 Feb 2025 15:33:25 -0800 (PST)
Received: from [127.0.0.1] ([20.88.39.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09b9061d3sm687188485a.92.2025.02.21.15.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 15:33:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250221222146.GA1896@templeofstupid.com>
References: <20250221222146.GA1896@templeofstupid.com>
Subject: Re: [PATCH mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <fb16f1f9-37da-638f-908b-c2cfc3229dcd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2025 23:33:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Krister,

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
uns/13466476124

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ba4aa4f792b5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936626


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
