Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908C6ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 22:47:24 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d187so3102157pfa.10
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=L4Sw/rmfnxtN/SiSpAx3ht5zD++HFxERmQLlp5DWdJo=;
        b=NikHNARShu6sbDa0oQgugUxW9IRcU699UzofuBEfupbXoSK6XfiecdPapE/aWrazB5
         NXzIwF59/9C7WBqGqw8/VdlL1FyWceirAV9aZDJwBBjnB/NrBVL4vLPk9FXhX9ws4Sm8
         Z8AgKaYr4bQK30brt48n8HmWNOHelWD4WHAKlH4nQ++YjyatmZRa/V1LK0+a1K80w6fn
         H+L2UkthdQDUYpEvUuLXzvvOuj6uFSQoEYTaACcvF6Dz2bzI9iWlLgWh51oAe5v1U7R4
         s1cqzKmNAffq6yd1XenWHmjO+HurVGXgHeniEkY8CzucpOD+w6AF9SL1boVP2ZpUR8Kc
         KB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=L4Sw/rmfnxtN/SiSpAx3ht5zD++HFxERmQLlp5DWdJo=;
        b=sH0T361gWGaOVJ5f/fZCue/X/BJLAqPM3JKWPXtvfiOnchLoZSfKSArursFN2YA/P/
         0O8cv2b678OhUdWYR6yIJgUkVUcKZ8BmDOfuMwYyCopLG7Rj4l58LvJAFnqi9wkXIuLX
         v2QQxKW6CLKcrAIDeluqWbEH+ws45dRupA6ndGClnVXTm7FtM6svCFLY6dlNgiLzQw34
         +ZnbID1oBg0TbS63xo9rZqQGeGvxiXiVPicB1m2kgGYPqWttxA6jCOt7/QITysgJGMuP
         9+pv5IPsY3khOG59dKb6PEGLHbRxHYmIwN5aw8YO5Ljyf16mWONJ9TId/8thsJZzYZ+R
         Wo6Q==
X-Gm-Message-State: AOAM530Gc/Tmy+rlF8fQk6W1ambVA8qSElcf4hr8xJcasq48BGFvfjM9
	/Qf9uHaN2/MonmVYHuTO/CLv2LTw/Q==
X-Google-Smtp-Source: ABdhPJzFF7xC8/aWr+drVecl3RDA1YJUTSL1whngMzKxM78dmDo0Gq0Nh1B7u5GI2Bzh9DYqJ0AYTQ==
X-Received: by 2002:a05:6a00:14ce:b0:4ec:aa7a:53c7 with SMTP id w14-20020a056a0014ce00b004ecaa7a53c7mr4933947pfu.62.1645742843839;
        Thu, 24 Feb 2022 14:47:23 -0800 (PST)
Received: from [127.0.0.1] ([20.112.126.241])
        by smtp.gmail.com with ESMTPSA id w14-20020a63af0e000000b003732348b995sm499373pge.12.2022.02.24.14.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:47:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220224213406.3127061-13-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: make it shellcheck compliant: Tests
 Results
Message-ID: <7127ec34-9481-49ec-535a-3e23b1b0bcf0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 22:47:22 +0000
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
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5258386722783232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5258386722783232/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6384286629625856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6384286629625856/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3aa95dbed834

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
