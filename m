Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA028399
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295577; cv=none; b=s3tYlisQClON+kx3tnayQ4YnO5ASrmuycr807bp4/Z2vlW647c46YJ0h0ZplX/pgucCi+Avy3OLN/guZzaDdrCgVFrhFUCcnNuZx5TnNO2K1UwFTJcokJhuxmuBGQegBOPgimuF/CWI1A4T38IUdt9ybU2yUoFurRklUwokqKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295577; c=relaxed/simple;
	bh=T8vKFZB5YGnXhkNjjh6AQ1ZzQEtoHFn9kKi0LX0ja18=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U6h7CyLKw84LGElmOGnsSVGGE01D4qSK3Wz2CgsBdt22gm9cgJhyyaxx2NF0RC9B182EKZ+x6dZIbI3MmSkfPp+kw1g5TBgrM/7k+LdZVHO9gMTPcKChCcHSGyMBvYvhJmiW62/rETOcxqxBS1cuF0ZFN1DOF3tGRnafYP9FuWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWdaQWP4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWdaQWP4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e87067b15aso291916085a.3
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755295575; x=1755900375; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtgSjNtkWFm0xXfOKcIwZ7cfAHWZMPdsYdFU8fvOOVQ=;
        b=iWdaQWP4qOiPX7vAfLIeIw8MtcbbnXiiddnaB+Wrk8j6KU7ACGM/b9YKLIXjUkzO/B
         F4YwwfHNfzHTb77O4Dx9euh+7v9TPKjQedqPiPdKbYYy7EKF7mJFBBLW+3x+od7K55b8
         j9+FEinXbDqZLeDPCH/qPoDkk7D5QnOsNBHu+KqufH/eWOxhp9fYs63/wm4ZMRQ/l1c2
         J2ZE5mQXht2Mc9I6PN7R6ucP/8g//B9LSJL+pOtDVHq2ebGTZzu6p31YHa/jU5xMWxF+
         Efje5YYEPqZ5A5hUKU+ee9HyfNf7VERdugePzJStcY6/FwIbTjGOhPqINq6kr/OS0JQ1
         H/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755295575; x=1755900375;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wtgSjNtkWFm0xXfOKcIwZ7cfAHWZMPdsYdFU8fvOOVQ=;
        b=bK1WGig2MdaehB46DmSNRbESNDsED0PvFo7x46whEYSftKJQt3+qRGmjntZ9NjrinV
         NGJSXlLDk0DDjUaWiy88ZDFXbrnIphKJDWLEuaGiyjzQcyQ2rycwgcsnWYyvrW0bexPY
         xNp8gZM+jpnzEWMFEh/bpIi0h3slHK5+mxbIIYjZtqCrbyHNzjzmcnztdpa1d4z7WJFT
         2XIoborVGwMoa2XXadu70w6c5c9NUKfOnGSXaiJdetXL0AetUMufN/2qOGLqgPq9QfsB
         +1GgQPQ23TY6w23ijIiHGwkQUiLJ2+QVKvFYR4wXcywCAXh6u26lYeQNqPI9cU14Ru36
         g7AQ==
X-Gm-Message-State: AOJu0YyRWi5FP3O0wWQzYSci4vTnS42aqbOxewFGrVYiQGGDmZqF/HEk
	zTeRL51dDZqIBoa+TFlxMjl1tCKAjRBesB4Y/EQ6emz6Sv038Dlyxxc=
X-Gm-Gg: ASbGncu+27aD/Y5/gbxzDBc3yYxOXfrg1WSoGn5KG/i0XAGlbxzvfJWbIjBfyw+SC0z
	O6jrRL1Fl4a62Etihk6z3CDNJtpjocpqYcX3+5ziLq+tmT3sUj+orxTsVwiH3gYIl++30ZLJwxi
	SksFLBK0UDqHV4+XZjMy73fdSCDEsZGk8bWfCeY2XhbwCsCddQww3TPx4fFBdKoHTfB6virsSYF
	TOLY9qGNXNpkqb8n3pjeMg4mv/ZOCD1UAdt1ok0FkxAo1plYZflScVtJI5fDL4n/1aIAlbEYje+
	ZdPI4ewJWJxX5XxJr33LF4iCqP6hHUMQCo2VGIaH2Iuwat3eN6GEu3oIxlCrX0vyNQ8LSf08gqo
	1KgM2K2gvF1w6w6hvtvwuIQgCvZPPEVL8n0DKrw==
X-Google-Smtp-Source: AGHT+IEXf08CQwDxWjFH3inq2CKexP1UjglFBO6CvgJ1R6A2qvgRKy5KJepUB84LGOIEt9Wc7aUQjQ==
X-Received: by 2002:a05:620a:4304:b0:7e8:6cf:5fe5 with SMTP id af79cd13be357-7e87e0d7d14mr519049185a.65.1755295574921;
        Fri, 15 Aug 2025 15:06:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1dd074sm173029885a.73.2025.08.15.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:06:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
References: <20250815201712.1745332-1-kuniyu@google.com>
Subject: Re: [PATCH v5 net-next 00/10] net-memcg: Gather memcg code under
 CONFIG_MEMCG.
Message-ID: <1ad47113-a4ae-9372-d537-320dc77b785d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Aug 2025 22:06:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

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
uns/16998832310

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/269f6acfebcd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D992046


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
