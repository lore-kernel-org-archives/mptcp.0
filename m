Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDDB7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:57:16 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so4095220pju.2
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=YDlKaptuL0EH7MWym0t+KF/5OMYUcy99gzisCtE38Q8=;
        b=nxDqyyDwrP03PbVy/Tr+bn/TSvRMKrLXPnsYKU8oZKwXeg0cvyrvWIiZwXvJdTUgGy
         lznnc4anfQzwCeCejJOzLVHQDlMy6et6wASRyCGhDzHzqh9zECskpp6Jy+Wr+Vakur5l
         ktxooTDBvM+nkvAPS7nHubCzuyDaAFPedjU7MZ57qUul7g7gY+LR9MIZ1pLDCck9PoFA
         6fZU2Nb8XmDC+z6rO2sICf0j9CB1fuXTaW1r9hmODrbt6clSIILmrAHTdpLsdu+OhRcU
         ZiKuYpIRvJ5RQKiFm2t8NXDui6AkDENZUeVb+I3QZsuZ7cu9W6noP3l8ZIGlyF2m3GGq
         gz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=YDlKaptuL0EH7MWym0t+KF/5OMYUcy99gzisCtE38Q8=;
        b=U6hgBFnznKno1pGnUcBSnM3J7v0V6K+x8KwVu85oBtQ4y4oCOUm9hExCeDtsucvVyb
         yI5/44wjLYxZ8wn/f51C2gDzzaJwp87XaLrCMrss1Ljl5Jk4KsPsqmizwEt99JQZkTL6
         sOz0vV6/kXFzt00N94atOnOWRZu7sGLjeBVsHOzG1PzqhIbkuUfbHdBxYIH8fPsGbhfI
         3y8zGr0Eaq9Uxjk9aN2qny0d/d86LUeMpwxil1zr7JRhQttpjtz1VtpDX2j8cco0T/Nc
         5URQclkTD833JshPlb6CIw6Fnp0umAFTfIcO8k1y5CXtOwFhWAIWw1R/E9kSUeCw3P8F
         +F/g==
X-Gm-Message-State: AOAM531CxtOI7AkHmwvKUnGMbdxCO9ZZ0UomHd6OL6Bm/GiPc0LbGCoA
	QFWunrf+yPWNfXqATSoreQ==
X-Google-Smtp-Source: ABdhPJzxfKiNkKvhFPK+6g0aAmPJeqPazgmBx8PExakbqKsYiccs51CNnfxQ9VMTNHsnxdfM6/uw7A==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr6838956plh.136.1646323036383;
        Thu, 03 Mar 2022 07:57:16 -0800 (PST)
Received: from [127.0.0.1] ([13.87.201.69])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a001a9200b004bc82d0e125sm3014687pfv.119.2022.03.03.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:57:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <59d5dd61358bdee3d5b1a95208461e20e006b8fe.1646320786.git.geliang.tang@suse.com>
References:
 <59d5dd61358bdee3d5b1a95208461e20e006b8fe.1646320786.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Tests Results
Message-ID: <c69094db-16d0-7dcd-431c-7dbd64f347ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Mar 2022 15:57:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5615310962163712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5615310962163712/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/4612997229314048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4612997229314048/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c95f5f7ff117

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
