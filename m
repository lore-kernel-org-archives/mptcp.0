Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09597C
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 11:39:38 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id b18so14910535qtk.13
        for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+Nf38dFMCwndRs+pA1HpKvfHU5o0VdlFTZgLNBoERlA=;
        b=f5+jMGv8VOr4uXizhxPG0C1CUcD2av113qsj7q0kB+wRiNEdkWlIQiYlnSvHXcMF8P
         q3OZH6WGs/u97xe137kkVjmk4a8gtzd4M15ou4iMT/5ljTIvR9BGmBFPX82sj4aH3a/p
         lPkbj+mC3wcyQWfUfoWz5u8n4I4HO89Tf/GppY1xkOFZmQ1f6kpsN/+D8QupXICMWHY4
         kHRZmmwsXdeF2RjQNmAKvDfTrTit5b08MtXg5iXHnJlugh9cwvTdUVfaGoJndVqedhLz
         05RrXqGe2AFCLirbhaHovp/Mr5dKmkoHNNyBPLeOXcsRL0fVDWsrNH/8B5N78m5PVkCF
         vMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+Nf38dFMCwndRs+pA1HpKvfHU5o0VdlFTZgLNBoERlA=;
        b=QGF03sdv6WTn7OQt0AOZptJzENtsyATUQhZ2iXJoXzl2qIGxJuOe6G1y3ztrPMM80R
         CqhUF7umzdh9nX2OzwA5jMtAdBHCzJ7JHcoz9f9LW94nkJh3b/fyGkQXbExTnXgVD4wR
         j4APSryMUjmhllYxmIepSwAn1ih5tCisQENss5v1dxdUEOsjlqSC29HEmUFpvuVlifLe
         s27rIvUH/YzeeOPUbNhQvooo1oynAF6bEiz20mkcPzNANEPqHXU+1Wn+n6qTDXyq6HM/
         wXMu+8VOD8IAh9xbCpfkDsbsmPxTvLG3YXqS2+nm0cUY9nNp6TWXTX7nrVK7+7FeVdL7
         2yYg==
X-Gm-Message-State: AOAM533TBQMAl1xO1sIjkSIvZZo8ZAwxt1pVeNeCys8FhCYBnd9Apip6
	Y5hTsc2CEx4c0ErtvtMagyryry+m9A==
X-Google-Smtp-Source: ABdhPJzimXbQLaQ5Pf4rhXRM6FtM6MBJFxXl/WyDiIGYmA3kN4fEPRf2ztjKkzCHflGhuouaTDn/XQ==
X-Received: by 2002:ac8:5c11:0:b0:2e1:e4d3:d19c with SMTP id i17-20020ac85c11000000b002e1e4d3d19cmr27062114qti.19.1648553977768;
        Tue, 29 Mar 2022 04:39:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.255.22])
        by smtp.gmail.com with ESMTPSA id bl22-20020a05620a1a9600b00680da570a5dsm2330728qkb.61.2022.03.29.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:39:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
Subject: Re: perf tools: .git/ORIG_HEAD might not exist: Tests Results
Message-ID: <34809296-159e-5867-e214-2c539fcd6bb8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Mar 2022 11:39:36 +0000
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
https://cirrus-ci.com/task/5186485547696128
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5186485547696128/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6312385454538752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6312385454538752/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d2e7106ae0cc

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
