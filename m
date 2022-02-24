Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716106ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:29:42 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso6973766pjj.2
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=PfwBVXBwcq3THtwI9l04GIjdqlFgg+Mq9HljKNcQcKM=;
        b=Yy8hfOsJrdtdVwPaVp7P40BLmewASnf0V12EH1JdTiMZum+UhNqO4ZWZluSaJRhq3x
         mQpiorY/l32kSx4+IgaOLSquw9xgHZXEPqiC/h+HXJOh/t1NE5kAPJPzu+aYX2IsbViO
         JgsV5qHGfSh5Rzmt2WlzoM3oj3YOJ1lPu0nlfx4uwQhvev+aU7PxHy5h4I4kkATGY6yt
         dwOnodcFRFB6PyAqWvRwKj+FdwZsE2bVHjyt4lW7J7FvY8O8bxKJuOJa6rNeZ4iIvWC1
         fo5nmA247UXfNhNtA9IYvGuUh+53ZLiufpddBgwnnXDG5nyo0EWb9CiYrsXC+WOaG5RW
         LFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=PfwBVXBwcq3THtwI9l04GIjdqlFgg+Mq9HljKNcQcKM=;
        b=dkWwQvxiC+nNkCHxlQojmDFKX7T67vdllmsd+aVwXVZLeFclMimCunec0EzbBccEXf
         SqV+6uaZH5j4J5Pc8CGMb0vmheqU/MGyrijkS/ktlocNbhp4ZuQWqFJYBd1KHr7kDOhE
         /yk/4d3jqG0QNyyMsm3ztQZJRYoSvH17fzMxOKYEL8KhgPktWmKe0ai6YYj3udwM3fus
         jLJKEbYv/3DFy5PK9fIErn8qLiSgiqMegOBLWI6R3TsG91ItDrvn7OsFshTwrLXDr8nm
         8jdO0vzYOIbpXrxcoxg6uHPbTaGa53WY7GY7pcqULVP6a0ihEGsMegQLvz+5itsjUB9d
         pWRA==
X-Gm-Message-State: AOAM5324VKJaVhkIBKroc3VCT34Yu3TTlbaenp6FjQzqUQfQq/NIbu82
	mOWK5Ad1LWal9bdGNHFUtYHdEMGhfg==
X-Google-Smtp-Source: ABdhPJyZ71FZq1sO2Dlk1v7Gouk2a0NFHQVqru5m10kuas3rTDztHPziSokOnW6f6QoDacsQHlm7BQ==
X-Received: by 2002:a17:902:7c0e:b0:14d:9791:39f8 with SMTP id x14-20020a1709027c0e00b0014d979139f8mr4718330pll.23.1645745381918;
        Thu, 24 Feb 2022 15:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.66.184.211])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm379468pjb.34.2022.02.24.15.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:29:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
Subject: Re: tcp: Add TCP hooks for detecting MP_JOIN on a regular TCP
 listener: Build Failure
Message-ID: <cd5d9e24-6d21-d36e-3d2c-e27770d6fc7d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 23:29:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220224232226.259304-5-mathew.j.martineau@linux.=
intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1=
895883332

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0f58cdeb67=
d0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
