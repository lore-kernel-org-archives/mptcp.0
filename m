Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6873214
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 22:52:47 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id k4so11028464qkj.8
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/GhIfkR57oAPLw+Zof23yYbOkPzJ3U23fUqyM07p4Y=;
        b=dUTpkW7S4w3/STotGFW1iTSU0KUlUXH3Hfm7ePRY8SCyIRY+wuehmMrGoU6iLHonBo
         ycY+JMl1ufjyoBAqFLNs+jB8OwV0zHWWEJJ7EMalKsmYnf5lvQAsOqe4Fxg3NxJW1QqT
         km2DgRuZLK8GxzcU23KMHqpUaxFEqwg4fpOY+VPT8umsgp1G+a6X7LEd4bIdErvZCOFM
         dFhD6rgLoCPdAzG2oOj9p2JmLv4LvfZphlCuitRgMZe6Ldb1Fk8x0AIiBiJEKbHGAPXx
         /ow9R9RbLcbKVnlmgIGED+Dt9zIwwBl7pnqndKu3R9wmFugPICT6l9Mk7k2MmfliiGcZ
         UrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/GhIfkR57oAPLw+Zof23yYbOkPzJ3U23fUqyM07p4Y=;
        b=tIju1VHU4iYj802iYWO8oAJqhLLMG2QPEM2Icf8tKue/vUljihcxrpKaUlsfmuB2n9
         cvkOo9wEqLJdLdHXKNsiHCJkZQBYXuNVjZs6v6jl7cpAnVO7qaWyoMi0Qyyyf3RXruE/
         LT3+qwv8JZrwSAeo6rZ4B3Zzsbm4kVfmjv+QWFrCRgXq6pxnnCYkTvwEeLVwjyURWWYB
         JkPJI0TXpGF07KA367xRyHKV2ysSe8m9hjRAJ8wfVFO6EztcUBk1Fh6wIqRXPIb0ER9Y
         kVa2f/AioeXjaB+crxSArt8uE2213ZtDBZ6fJ/HZjtzSwcM+iM0t6973crCaIprXaWwB
         vjxw==
X-Gm-Message-State: ANoB5pnIa8Ux4D5whfSD3LZGvdh913iXjWGOUZZa2ZOgSBqG67ok8vXz
	VMkDk15XdbD872BeDld0szssm3Nv0W3tgvA=
X-Google-Smtp-Source: AA0mqf7AnpXivkETUMzZB+kGIFe1n1WdcTtdES+30v94pxK2oPRmsIf0f2eL5SCbUUCOsObSKCi+JA==
X-Received: by 2002:a37:b342:0:b0:6fb:bd2d:ea95 with SMTP id c63-20020a37b342000000b006fbbd2dea95mr35443744qkf.111.1669762366698;
        Tue, 29 Nov 2022 14:52:46 -0800 (PST)
Received: from [127.0.0.1] ([20.163.221.218])
        by smtp.gmail.com with ESMTPSA id r5-20020ac867c5000000b003a56796a764sm9308331qtp.25.2022.11.29.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 14:52:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221129210804.3769157-4-matthieu.baerts@tessares.net>
References: <20221129210804.3769157-4-matthieu.baerts@tessares.net>
Subject: Re: mptcp: use proper req destructor for IPv6: Tests Results
Message-ID: <bcebdb62-7468-2d9a-384d-a1c3973b2b03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Nov 2022 22:52:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6286458267893760
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6286458267893760/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4879083384340480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4879083384340480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f559e986956e


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
