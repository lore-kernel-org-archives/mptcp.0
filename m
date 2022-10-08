Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27867E
	for <mptcp@lists.linux.dev>; Sat,  8 Oct 2022 04:10:39 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso7556460fac.4
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtSeghFMXlyfQVvhRwApK/QsPkow72ZbLFoA6g0hChk=;
        b=Dw4ym21IgQFf0Oak5wFNz1coOH0rp9orQzLlJMFMzECcsQ9uTiNIt9ppp4//3GqWZu
         HFF1sFe0kOoBAN90pf4JyxbGM3P3IIk515u1qCVPlyJ1iaDo7DLLbZJ5Myai8VC7EhAu
         Wn9Sq9sr6S0QHnB/wJUZ6wnMV3ufoau/ZDHapsgVtTgJ9cRJbqwumuxTeA/gcraVcacG
         eRo8iY9lvnmj4SldXw5f/KkSssS75jBYfxbTWkjrjnz+efoRkoav1HxENUiV5++korf7
         MgiSSmOt3eCfxl/YycLyKDuwcObyP3xLHBSx1BiPZm4d2qLjlX4RsFZEiX3Ib4n0ixUk
         3nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtSeghFMXlyfQVvhRwApK/QsPkow72ZbLFoA6g0hChk=;
        b=2i0rHSrbhDNhfE9OIjQFf6Mhm85u5l4KOIcYV8U4RmKpVddckw/EGNI43Jtm6lIne2
         VWGu2M8fjceqmuBpRArrNC/5Y0aZB0qBaB7s54JzNloSYrxtE5nRf6QxAqVH2CCvkQM2
         dFbVNPDKw+xUJa7VEFuQ2gaxd8Nu2+kJ15mHnXQxax2igAhmEahLnAvMFC5WJ6TSYBGG
         DrGiNnsuWoixYUlTXqwR2Gwk8b4a+ggcjaomdvPY5rG9jlpsSQcn7BA704Elf5SZWM3T
         fV85cfIIVYSzQhx/rsAa+j6n8FsgrsUR6h4BSIqmwkREdZnYeMmBggc49BwKvSQSDq0S
         z1vw==
X-Gm-Message-State: ACrzQf0RIJqqMIsQ1zTLs/gs2+EOv5rCviswGas7+vXmKILI7e5YL64P
	uLAdW9QUziplLn5n+IXcUA==
X-Google-Smtp-Source: AMsMyM7RW2oGlSuZmcCdQWLqDUyJC94QudShnnsmm/TlUJON8aPGF9VwXGzGGCEnQ/Nw2Qo2IJAgzw==
X-Received: by 2002:a05:6870:e88d:b0:131:87ed:c3c9 with SMTP id q13-20020a056870e88d00b0013187edc3c9mr4073573oan.181.1665202238876;
        Fri, 07 Oct 2022 21:10:38 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.155.172])
        by smtp.gmail.com with ESMTPSA id s40-20020a05687024a800b0013626c1a5f6sm1265737oaq.10.2022.10.07.21.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 21:10:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221008040015.21176-1-geliang.tang@suse.com>
References: <20221008040015.21176-1-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_register_def?=
 =?UTF-8?Q?ault_scheduler=22=3A_Build_Failure?=
Message-ID: <448667b9-bc07-5272-b0dc-367cf33cca7d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Oct 2022 04:10:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20221008040015.21176-1-geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3209060322

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/78422b08a6f0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
