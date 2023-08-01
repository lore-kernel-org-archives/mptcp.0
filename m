Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA67E
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 00:43:29 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-686e0213c0bso3505186b3a.1
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690850609; x=1691455409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhtZuHVuD/5ejYMblEMyj6RnAY5Q/SWusGE7WOY4wLk=;
        b=RVDofTb81vwCNbApr9KlLqeCll9uBMlfud/WfmddUfEN0IK3PpETDcLv6Q8CrKqyGc
         vrGsvn3wQYftFQ8P0nKXwzd4g/jbOqkt02t1/eY0RzKfpUTztKsHrxEJfGaUvEBoHnza
         8oTL79e6ngOzRjUfNCcKD6awElo7WX7j9wnSP+2/XEusL/SbKzOD9YZ6R9Pc63GOWq3W
         9s8APfiP/DHZEct6jOAEcxB3S5B93mptSEUqVTSi7uPzc6ZDsZP3Fv9AJK/bqsY+UKeS
         xTw0ePYHH/dpFa9JmYBlfnqooLGD7NQpLva3ftfWSoB7LC/7+CUIcaXZ95Up8LkDp0I9
         esNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690850609; x=1691455409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhtZuHVuD/5ejYMblEMyj6RnAY5Q/SWusGE7WOY4wLk=;
        b=Kl48s1ajaFHIPvubCW19I6MEUikaY3teTJ0txbc6Uc4zLExE8jysqDFAK97Zu9u8la
         xTZQvLsLExUCTHRQ71BeYcpayD3oAkk43I0vpq5Zu1WLauIjDbQ9vy1HQPbNSVES+Fmt
         pHztwWrMuUhI2mEMSriSCitgUoN0PffOx3JtjcxN+zm5RlfTQXGGgLNshpvseNKjZ7zt
         JjQJEsq/oehVm4v3zMVHMftcVOXT9wWUuA/8eMIjRKaI+1csd3+PqC51xpV6T3dCuAte
         vCwB7niQZXTIZZyCfSaBl3uMypBMFAeisEwwuaAvjo20rwgLmAY7kk+q2YCzrGj8WqnG
         DG0g==
X-Gm-Message-State: ABy/qLbgiCXfhPHXARXbv2kZooT9UPU039xSnOuhODGo+80BUeeebjd5
	TGWyNuIt5Ig9b6/0QcsdQ9I=
X-Google-Smtp-Source: APBJJlEDasJjNH4eP//Am3nFp4ZsQ53OoZYJ+ckrfSoVwD3WviUA3efisvHN+OOYWAmDO2aQriVD0g==
X-Received: by 2002:a05:6a20:4a06:b0:10f:f672:6e88 with SMTP id fr6-20020a056a204a0600b0010ff6726e88mr9441980pzb.4.1690850608691;
        Mon, 31 Jul 2023 17:43:28 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:6cea])
        by smtp.gmail.com with ESMTPSA id y15-20020a637d0f000000b00563b36264besm8688220pgc.85.2023.07.31.17.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 17:43:28 -0700 (PDT)
Date: Mon, 31 Jul 2023 17:43:23 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Brendan Jackman <jackmanb@chromium.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
Message-ID: <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
References: <cover.1690624340.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>

On Sat, Jul 29, 2023 at 05:57:21PM +0800, Geliang Tang wrote:
> 
> The main idea is to add a hook in sys_socket() to change the protocol id
> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

I still think it's a hack, but its blast radius is nicely contained.
And since I cannot propose any better I'm ok with it.

Patches 1-2 can be squashed into one.
Just like patches 3-6 as a single patch for selftests.

But before proceeding I'd like an explicit ack from netdev maintainers.
