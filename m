Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC020F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 14:18:17 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id o22so2507518qkl.8
        for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO2RwJ2gd9nbgfvxwAdpzLRYaqZJCvTUdI3Pne1kPT0=;
        b=gkCwSbytCMrkao4TYbsNrPkfFgVpL63RmX6HzvlzIkn8li+8NEtN4ifTF4PFZJlx9k
         AGocAmOPsDgOzg+3x+0ytNRuFWRLT6K002fpCNJh3/q3eFS1bpM107fdnmNiu6VFkfEz
         J37xkoCbwO5l2UDdKrlv6xPMhx/K5wFcBGCgw9fxDcidahLS/Er+mARYQTGlMpafTr+t
         Jt3LzBXVa3Izadl7oDShl6tJCrSa1OWd5XwgEr3bAJaq1F4VVrACjGC6g836x74zWFJx
         rlwqV0ZiODn1zlqEXqPEwj6Nz1dNY1Gzh/G6N4L/bUH8nOkl0GlwXQFtwZXzg9NZPKN2
         OZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RO2RwJ2gd9nbgfvxwAdpzLRYaqZJCvTUdI3Pne1kPT0=;
        b=X8NVFF24O1Wcq3vy4W0+C1fixNhzqgMZC+5hRxwRVp3XZ5Ab6mzWCfpDX9b2Jtlq1f
         dxZXdtleiY4ihQdTIcAwyYt5HtUY6FQZts8IJo1bYXP94So69+s+gnc3BGXnz1Pn1+Z4
         bWxxiumzmJ245R1fU3DiZOji1pZOpRc4OsxwSNnqmELTWFJ1e0n/DtlkrycGSApDgNW+
         fLY2ff51mkdbnSwoInheBIw1jo97d85nK11M99Dh2H2IMlXM7M4wqxQGsMGdk5Nu7cjv
         O2IjcF+SW9fkWhNuECQuOGcF3v60mOFajNUdd4zzibrAYe/PF3rm8xfwRA3hB086YF/v
         j99A==
X-Gm-Message-State: ACrzQf1cVSUnTd8Giuovm35wNWXvMEKLfm8hI/q5tdIZB4eXrz+wqTxJ
	01u/V1xmR7TvKLF6Qn9Ysg==
X-Google-Smtp-Source: AMsMyM7NEHnXqzMampWXw1Y8xJNgQ6bQMKZSwr5qt+ofpf96aXw8/QKJXL9sk4Gcq4iXAh/q4rgfrQ==
X-Received: by 2002:a05:620a:688:b0:6ec:5699:1cc5 with SMTP id f8-20020a05620a068800b006ec56991cc5mr3864581qkh.536.1665757096651;
        Fri, 14 Oct 2022 07:18:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.65.60.252])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006c479acd82fsm2628586qko.7.2022.10.14.07.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:18:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926.git.geliang.tang@suse.com>
References:
 <a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Build_Failure?=
Message-ID: <21830735-d5d5-8ff2-5c50-abc01bc6d42b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Oct 2022 14:18:15 +0000
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
org/project/mptcp/patch/a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3250457897

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7d41245580=
2e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
