Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DE258E
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 17:04:00 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so380383pjb.3
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=w+qt2AXuCJKhMBzRygkGCBo3Amr9Ccu3U5RjuiDS3wo=;
        b=MBklqGfOa1D+Vnv0yezhDuCxi56UniMbX7S/0QKIJWykfhXrzYfTUFdprmLn195SJB
         JZbzz2ui+7mKyUpJFb8zM3KOOC9T9hoChKOeRlEtoPjRrzwCrY4GkDUqUh5LTp7W8Sjn
         WzB6k+OUS/tEXjfYvXJsrjata85W2VVLLf3dy1UX+IgdkNBU7bLZXWRwjHG75L/oATwR
         GCiFeh/38ee+2p5k6JN9qfH4LDqARmU0ZlcENLqmHMmbQ+8GdCowaQv6dQPanaK002L0
         mXyprGmZ77f+tV/tj/69BwMoeFO81BM0Rvfa3jcjKT81dyId76qFYzdyvy8EFAa6iPVa
         HrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=w+qt2AXuCJKhMBzRygkGCBo3Amr9Ccu3U5RjuiDS3wo=;
        b=UrdKUwVdU41/fV/wu+4zORbk1eUvhjFgq0IZJnL9wyOGXVE6TLopYMULp/AberLTTw
         I/kjgu8G8OHlxJ4CSsxXZFsP30yKgBck/QxYd4hw4UGf/L+H65sVZHNipyKfqFZMg1Dh
         KCOK/3TG6lrHGpOG2ed2cQpRcQaa5NAE6724Q7M88TZhPZP2YOYaDkzroyNZd284kikx
         9D1KLk2Gy5cn7c3PAJ8sYfLeGzkLwjGOLKPb5ADZKwZxye/J4M+vY93ND5eVcSx3F/mx
         sWFDw9i8IJTqYuCng+FQPe6tIAonN5sWO0TAe+YaXW0VhMHyZlc31xDIk4OwRa8IvUs3
         xt2g==
X-Gm-Message-State: AOAM531ifPWtFU/31jhItheQg/Y0fK/BF9lYXzOg8rss5/FjgtG7DX8E
	ThcMCHXF7XgvIaeW8GgEz8+e5fdHYSO0
X-Google-Smtp-Source: ABdhPJzOy5HC63NcavueP1BzrHBhhhl+7A0OHu7CRZqeNrkW48hbh6Zfj8qxXqssWDI1ICiuvuyOdw==
X-Received: by 2002:a17:902:c3c1:b0:156:1109:2383 with SMTP id j1-20020a170902c3c100b0015611092383mr611292plj.64.1648659839692;
        Wed, 30 Mar 2022 10:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.220.62])
        by smtp.gmail.com with ESMTPSA id ob8-20020a17090b390800b001c6a1e5595asm7711948pjb.21.2022.03.30.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:03:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
References:
 <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add mptcp_bpf_first test: Build Failure
Message-ID: <7ae034b3-5879-7273-6d8b-cc28484f5638@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 17:03:58 +0000
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
org/project/mptcp/patch/50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2066170068

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ea9e0f5c2d=
fd

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
