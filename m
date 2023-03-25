Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA617631
	for <mptcp@lists.linux.dev>; Sat, 25 Mar 2023 05:18:25 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id m6so3181933qvq.0
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679721504;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfJ6H7OubGGf2pbIakuWZSiGsTsko/JW/WuElG1haEI=;
        b=p7mJoV694p5HbuY17XHW631T7r30N754/4MKpJvrURj+vgrfqMH/sd91Y9ej9l0ePr
         cVcI0iJE8JOTprzFs7nvZxqkJ3fI6y1hI+80BeyYt0a7/JO4bTEUEyXpKnyaBwtKnHQf
         3/Je0/O1ay2QmNcWyDSLKyXLImtdMPGG5G/sIu6IxLcVp4TEtVJm2lHzjL9X50F+G8cM
         6fliNUp2RnfQE2rwlsieCaS3RyDVg5XAhHyXAup67oQKV/PXG2EoUfNi0zga6DZDp+Yy
         IoSOQsOEXipVUqIIGzujgV1YcLxbGHefwVyy5dI/XoOd977ZGTQCWIphDj54+z9TWss6
         x+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679721504;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfJ6H7OubGGf2pbIakuWZSiGsTsko/JW/WuElG1haEI=;
        b=n1rRS0lpsCMuOVrRk5k96MRdhMMRZk3nsqr5vTwxrR5OQNrtIL/d1xvF7OjMf6Gc07
         E/y6Jw2+HRAivNYTmEs/5s+wWUWYCZjSj2X9jWsCBYeTMHAqH7VgPDsqkMAKHgXltIkj
         VachAk6SaqHoDEbrObwZfFmaNdvvZFmFJkofYScDPw2ySG+Wy+gQ+gxYJcT8dg6O8U2T
         9BKul8451coY/yKAkPxlTNeADu4on82ikkb3eELlZhbifyQyqVM+vXjqdXt2ukD09CuX
         RPwhnTFvJnTAaXVbTJ25KzIqncgDzhkNz5HH2UqJjr7BngIuFhmSFwCvgX/x1j3bc8KN
         lfgQ==
X-Gm-Message-State: AAQBX9ewFoJ/RIs1H3n/Ek83aTa5PfV6wvh2nv51seU4o97Op8Ucm1N/
	6eCF6MWux+/Q0oGqQezUxfatwYtY5y85hR4=
X-Google-Smtp-Source: AKy350b+A/2Bam2ww7+iz9iocgUWwOhm3vPzhSlm+iKZzMCdR9j4V4NsrOw8ENMxr/7PwvbiLorTcA==
X-Received: by 2002:ad4:5bc9:0:b0:5dd:aee7:e016 with SMTP id t9-20020ad45bc9000000b005ddaee7e016mr6787867qvt.8.1679721504527;
        Fri, 24 Mar 2023 22:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.213.89])
        by smtp.gmail.com with ESMTPSA id bk12-20020a05620a1a0c00b0074357a6529asm14931806qkb.105.2023.03.24.22.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 22:18:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
Subject: Re: checkpatch: allow Closes tags with links: Tests Results
Message-ID: <a5f39672-1251-4da3-9fce-f783e7330912@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Mar 2023 05:18:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6730930425954304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6730930425954304/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5657807077244928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5657807077244928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5094857123823616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5094857123823616/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4531907170402304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4531907170402304/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/49b26cb5b35a


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
