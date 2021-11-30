Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662D2C80
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 17:02:30 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id r2so21928113ilb.10
        for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=tiDK+mYxgU3dzpR9AhbRosH9v1523pULEQ/lrC4Ghkk=;
        b=a5qRRjcBvlfXB4TydGtzhc4SHGrwGSQwfKkYVd8b6oP8GFuJysHc+HbOJmAgag3nab
         TyZgUnA+oomT9JXmwaxQoim9mftzm+CMJTASNhjrsRzTsJaSntCLx9QUqYT9DjHxROFT
         pR8B3uS06qzmWqhIrcTnVUv/SU9+3BLIX5wPWrfkNiaddaDJKWDBc6UZFSuHZGyJAPcf
         5Px0vycs9y2u+QsbwTDGhB2sJ7d8T7od96YfS8csFyjL/BDA/0KtM7Uw/OG88/5wcgGH
         3FRr41uGxeQDsXE+yPsSo1d842R1DAMIaJU/msbukaK8vglwl/nJX0F8WocnMP5DewK2
         b0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=tiDK+mYxgU3dzpR9AhbRosH9v1523pULEQ/lrC4Ghkk=;
        b=mR3AZNxCrzQavU0yQA0Gg1iNsrmdaVzp1ejNAvYknMwjfTpl4rRZxbvPAc9rm88VwY
         vWbelwdJ+iRwM3q7I8IKkNt91NDPhyf/vfIWnBvK5ZsbFh5EzgX4uZeEgfrQLjHpmV9a
         XEcGX1J84Vyil222L9VdvHjBTtQTQnEa9oPnahElp6wLqe2pxJGQNQpXVM+CkqRhIOEd
         xKTvFjabUcfAJnP/9tIaYahsNxuuMKulQJV/Rb+hbQJIIW0bxNhs59YtQPzG5rGtOg0V
         kOt2CMP2tffr3A6dqZHGL0Ihs9aHxe503CRerkagW2E/9XG+zIHR806zWnarvHYeYN57
         vU9A==
X-Gm-Message-State: AOAM530CRkRJVzFL61MA4Un58IFFR3dgVbgOGNjALyrfgwGITIoixAs9
	TyPaydFPa8a7NnAHu3YY4dRx6JVb32JL
X-Google-Smtp-Source: ABdhPJzKMPTGudJjPvrYJxSRmF4CcBjo/NvoINhQEgJB8Y5C9ocTnNJZkPyh/AkP85iz143EttDU4w==
X-Received: by 2002:a05:6e02:20cb:: with SMTP id 11mr240095ilq.262.1638291749682;
        Tue, 30 Nov 2021 09:02:29 -0800 (PST)
Received: from [127.0.0.1] ([52.176.160.242])
        by smtp.gmail.com with ESMTPSA id x5sm9983627iov.50.2021.11.30.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:02:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20211130165527.1506827-1-matthieu.baerts@tessares.net>
References: <20211130165527.1506827-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_implement_fa?=
 =?UTF-8?Q?stclose_xmit_path=22=3A_Build_Failure?=
Message-ID: <c87b5b40-f844-31e8-105e-dda1fa0068a4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Nov 2021 17:02:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20211130165527.1506827-1-matthieu.baerts@tessares.=
net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1521989=
225

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6efac2b03aba

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
