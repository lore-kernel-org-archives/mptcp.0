Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729C10E8
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 01:46:29 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id o43so23154106qvo.4
        for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+kbOGt7/BvwtIXQjcwKNMOVEVVCjZ9P5t3ZcTynRDh8=;
        b=VVnSa8au5hst9T3MwNZv+VkO5kkgWxpOqQDCIG6f3skihyHt2/joHUMtdJFUAXlyVo
         J4CwFp4w0AijVt1tnDuAb7lcHuh8yf8yhnL3vclCBwaw98hVY7FyMol+3NmE7J/ywVMG
         aCotyvk4uwM59zi3ixbWELmMCHP3HdTNjTrSmxtfPzy9TwXBQx/J3WJVcg7tK73vGdtP
         PsWhlPRbb+FUa07WcQz0zu4vERCb5Wte5N/aYUM+m+fq9iQa/layjFhz3hrfdWzzrGvu
         tKbc5ikH2I10x8MyeGFbnunq/hbCOgzBhD+wWDs29l6V9Iem5mJxYfNZLlPedNKdXG93
         afKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+kbOGt7/BvwtIXQjcwKNMOVEVVCjZ9P5t3ZcTynRDh8=;
        b=bch8MnFTYSMCzQTdP5LlGDZsA9l/k8qsu0ATUbT44uj2QnH3chslINi84NHbSxxEJO
         8wToiTCme0/PYHIKQSVGUhOIr6kV8sEd8iwdiqrrpJ7KS5e6IpsDCL8p89uZrTiqgxhM
         hJZDtuv7mIioBZ9MH1cWP6p+9GI1sAo3LzIm1uc1kqWSC7dNk5IQi7vUggr0kXwGWwSq
         6UxfQZ2mQfjHKbBTFfTqfxVduzWAB0TzB8TZwvVL5w5kMUNzSm72jk5Uz10P2gfzpcrW
         LHCeneAQZuslQxCcTz4whbzsQ24VmwJ6DLhKvjgB04ZB70w09LIMj7CzNirjjmlHB31a
         HC1g==
X-Gm-Message-State: AJIora+m1q8jTS0UIEoOrFH0cDSvzcVEeB6iuMs7COV1KThW7oO0LGSg
	gWntrcMyN0bt3iiVuLA+qdNqpHVr3x12phY=
X-Google-Smtp-Source: AGRyM1sgfnfYpxtQITGSOJH1ZFDFRqg7XUTCxdVFIK9YkXyWTrFBr9mOtPVrrcI9IMnvhyjmyFuD+g==
X-Received: by 2002:ac8:7dd4:0:b0:304:ece1:bb5a with SMTP id c20-20020ac87dd4000000b00304ece1bb5amr1038242qte.133.1655862388079;
        Tue, 21 Jun 2022 18:46:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.123.62])
        by smtp.gmail.com with ESMTPSA id y3-20020a05620a44c300b006a75a8fd54asm16734982qkp.84.2022.06.21.18.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:46:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
References: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
Subject: Re: selftests: mptcp: Initialize variables to quiet gcc 12
 warnings: Tests Results
Message-ID: <78bb4cab-baca-5af7-20b3-956ef683b493@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jun 2022 01:46:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6252603284652032
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6252603284652032/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4845228401098752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4845228401098752/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/623b51ae3220


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
