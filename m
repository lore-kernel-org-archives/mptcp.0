Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388932F2A
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 18:14:49 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d22so2908168plr.9
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GSjEjfYwxU4v4RbcrupK/xs54ee+hZE6z2p9pg9PhCw=;
        b=GhZtt50KXRNmhvPIVC3END3xVixKmwMxg0AXvayG0qxBRjzD83HfoFFlWGJHUzZdeZ
         bdQPaGFdGzV+Q1IfMYIdvAexd/sCi6yIv/7yeA+jyt5iTQKCq8IqEa9QW38VTAjgXwNW
         fa5Ve4fp9ggFhg0SJqS5/WtvKf8fR6ztFiZE4x1HpSdFGlGv3CgsmNXLJuU3VXqcB9f4
         PzJHk/ALcg172L6guzJkvmE99NsIuyEypdWQjsh6wBIGBeC5pDB2aMnpAOsSqrh6VP9/
         0b0hlbNarsr2BR7Gcl3pnS7spwmlmifeg5Mg8kSS2Zmwt6lMYkuIHzlgwv/KNmn6jgA6
         4n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GSjEjfYwxU4v4RbcrupK/xs54ee+hZE6z2p9pg9PhCw=;
        b=4ILN9ozR5/jjsORUIqy0doqXh/erpar3UIZEtjqaUJ/5kLirCRMigPOe2nD4+98cDP
         4OAk+oQfNinL8BUj3q8+eSKLQR9WuQHehqlZ/Q0jv1eotbPysEbLzDdnQItiZv1KvgCr
         iqay4Cf6OcsZBDXFceffHUrOCI4YS2Om9RIlKqW1kg8GbQ9irqWsWJNfFeNh3OWbTIWw
         ORj+nhMk7SuTYNHCqc/2qJ9YVXiRXRiw9JRX2pykj0JWQ0aeYvm15KqvPYiAr+macaol
         eYQfhm9SldsCZ9q+ubopW+G0uSgWcAGZ1KkxKppFu36NUQKGIGPH+Z3OmLGd3AHttpJW
         zt5A==
X-Gm-Message-State: AOAM5317cCUbv+xAXyK8KATBOsfXin/LZ15bZdHm/HMoh+KtLxqV0/tw
	6dBWVJVdIzMLjAFR18mb+7aQkX7JCPN4
X-Google-Smtp-Source: ABdhPJwoLaFwCBFat+nQaGmrFRbjtDaYdGXwZmGgR6yEdshnlmlolubdwWZX888h0IPxBW4CC958nQ==
X-Received: by 2002:a17:902:ab59:b0:15c:f4f3:7e3b with SMTP id ij25-20020a170902ab5900b0015cf4f37e3bmr13225765plb.24.1651515288583;
        Mon, 02 May 2022 11:14:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.228.81.248])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79383000000b0050dc762815asm5001959pfe.52.2022.05.02.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:14:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220502163641.6146-1-fw@strlen.de>
References: <20220502163641.6146-1-fw@strlen.de>
Subject: Re: selftests: mptcp: add TCP_DEFER test case: Tests Results
Message-ID: <fda6017a-271b-d3e9-db05-3503024200d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 May 2022 18:14:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_sockopt =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5785434943913984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5785434943913984/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_sockopt - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5457720147968000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5457720147968000/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/da7722c87e4c


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
