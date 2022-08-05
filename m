Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD11ED9
	for <mptcp@lists.linux.dev>; Fri,  5 Aug 2022 13:37:35 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id a8so2788614pjg.5
        for <mptcp@lists.linux.dev>; Fri, 05 Aug 2022 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Z+fvXFWDDbJLBEQuokIQvW22VejjWwYTqY14HkFFnUM=;
        b=k0FQ7Aa4MMgHmy9asBPKNLM0H3TBTAiL8U6u5gs7r1ZHXH+BiHATvk1CwKqbjfvInB
         ywnMxuR2DlTLQZKKNk+O4q9CzQYEAyGAOAdq1D9kEmGCB+uHgDitXMmsm8bMz0FHeS2v
         IvYpMgILn9suFTNlpwlZZu1Hw7eKvjJXYY1kdCxHo/iB1uidSg2RQUHgSkkpyzhhMigW
         ZAObVKQad1obmN5Ah6aTrMcfrYgVJC9DbzG6TJNdXBlg0ZnGrTxaYUyRve3jVqQprVqR
         z+ZHgteH53UGMS8C2ucdFToX4o9YthlTX4ZPbTaPstDwAw196REgy8WnHS1dgd8BD5v2
         skGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Z+fvXFWDDbJLBEQuokIQvW22VejjWwYTqY14HkFFnUM=;
        b=kgzKpBD2i5hSDpGNuuGTYQRaxjrQH4UmMkQXjLkJg3g1nx2Tvn26uxlcC+ldESfek4
         t4RaTywVKmK6/UiC7WIoh4HhLn2/V/pEOYANLDFaMxni4MPOB9C1xpbZO8l/5SNOI7Q8
         aqyCPzxPuXiG3I3h0sUsmBZ/WaI0YEtcrjbMyXO9+EDjWm0pSvdnhwcOApk8+0X7lRHa
         9dib5BWrYvIhT1sNsZvdPI+/M9V78j6CbKASZLWIcXZVe1XS0q/DjQ3sQL7d7Tt7G0ja
         NKAAHAZZe6i5ddlNZoIRq+TteFAvPZ9xCSzKmU/36foIKAsqITmk08EAyfk3EnvUJrzJ
         1NjQ==
X-Gm-Message-State: ACgBeo12hBy57AqQrRtAyimcxcEF307U3jaMplVFMRF+B5HUkl9kOnVB
	85hLFzLcaulTQHvyDhwHXw==
X-Google-Smtp-Source: AA6agR6X8AP1hORWXkZ0TPt5atDfG+YtixVSYqfeqJew13uzPBKCt08wGIIxGLbvW5Z5kRgnPmNMcw==
X-Received: by 2002:a17:902:8693:b0:16c:db86:1c86 with SMTP id g19-20020a170902869300b0016cdb861c86mr6759816plo.9.1659706654711;
        Fri, 05 Aug 2022 06:37:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.173.85])
        by smtp.gmail.com with ESMTPSA id p9-20020a63fe09000000b00401a9bc0f33sm1467675pgh.85.2022.08.05.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 06:37:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Thomas Haller <thaller@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220805115020.525181-1-thaller@redhat.com>
References: <20220805115020.525181-1-thaller@redhat.com>
Subject: Re: mptcp: allow priviledged operations from user namespaces:
 Tests Results
Message-ID: <2c2acc73-a8e2-662e-8558-432efd4a49ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Aug 2022 13:37:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Thomas,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): kunit =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4847158800154624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4847158800154624/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): kunit =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5973058706997248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5973058706997248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c384b8e857ac


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
