Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C67E
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 02:23:34 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso77061341fa.2
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943012; x=1691547812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FguIqfO6fA0en1tAJcHc1To85beuh1CsHQRCqfyQt0=;
        b=d1uLtGhtE4ga7jedFfoU52u3XFP5LL4+sF4vs9hz0lH/pTqgkQTBLCKYzdU+lHBLvn
         5NadrBu9uulcQs/MVVEXgAnBrpUunlu/UZXaS3ilaDS66w0HMewijXOXN9eqEDQjQul2
         Y/TLS6Nhj+60BHQrXfhPPLeCQW4959KG5l0F4RiIWUGMzT8TJriVj9RGrmZ3m/jNF9mN
         VT0q3AIlC++O5J/3ELqS9WYwi5M+Yg0zQ5q0VuzOIlBNeJ7jWiNe6oWLXWGEMUnOYLV8
         WyQt+g3zhsi1/Xdht0ZsRqsJQQVmbPTuyx359Xwsqxpmyc+L/xgea/8PyaKcEoGn/M9+
         3eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943012; x=1691547812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FguIqfO6fA0en1tAJcHc1To85beuh1CsHQRCqfyQt0=;
        b=ZwzSZutnfU3Z2HsznbtCuCskaWRYZvPYtJjm0cndZF6U2AU3rk2WZkwA1Qqf8NRBml
         j7STYvgXy+eYuHypN73vcjUAzxaZ6zgyYxEmtm1bOib6QAp1hULZIBHRi0PYeuNUGObz
         KyA3sNZK7KX/QKAqOO74RzxR+oe9vqtKpQ6/5pO5A2QypAtqtBK/re1DVmXZLRhP3SUz
         UQ5Je6K4yPoSJP+M4RJeohj2b8y++MmdxaQt679YYbHWmgTGgC8ooUL/dqxAYwUuEQAe
         Y+ETEcTkTqgmpQbVvSrna26CpgausKZugzU9636iX2HxF1rofL4FWNzWU4U2yJPtFvcg
         EYtQ==
X-Gm-Message-State: ABy/qLYUjTd3XrntVnDw8moaoNDOUicdYaNBTpxtGBTHnHBfuki6zmzP
	QsQRX3vCpIXHKv7BPYpFXJWlCwMM1aoPIjxlha4=
X-Google-Smtp-Source: APBJJlG8DpVQd1HX0sziPuWjT0LVfNpCxEMyII6e8Er09IIz5vcp1ZwFHDi/kyZCsVnrgHRgcFINXGCy73y0Os8s2MQ=
X-Received: by 2002:a2e:8ec3:0:b0:2a7:adf7:1781 with SMTP id
 e3-20020a2e8ec3000000b002a7adf71781mr3969470ljl.2.1690943012233; Tue, 01 Aug
 2023 19:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1690624340.git.geliang.tang@suse.com> <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
 <20230802021903.GA3070@bogon>
In-Reply-To: <20230802021903.GA3070@bogon>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:23:21 -0700
Message-ID: <CAADnVQJRmXy_iFBsWLTTKBnmwPjSJP+7RLfJwB9GUb=GEFoMwg@mail.gmail.com>
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Florent Revest <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, 
	apparmor@lists.ubuntu.com, LSM List <linux-security-module@vger.kernel.org>, 
	selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 1, 2023 at 7:19=E2=80=AFPM Geliang Tang <geliang.tang@suse.com>=
 wrote:
>
> On Mon, Jul 31, 2023 at 05:43:23PM -0700, Alexei Starovoitov wrote:
> > On Sat, Jul 29, 2023 at 05:57:21PM +0800, Geliang Tang wrote:
> > >
> > > The main idea is to add a hook in sys_socket() to change the protocol=
 id
> > > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> >
> > I still think it's a hack, but its blast radius is nicely contained.
> > And since I cannot propose any better I'm ok with it.
> >
> > Patches 1-2 can be squashed into one.
> > Just like patches 3-6 as a single patch for selftests.
>
> Thanks Alexei. I'll squash patch 1 and patch 2 into one, and squash patch=
 3
> and patch 6 into one for selftests. But I prefer to keep patch 4 and patc=
h 5
> as is, since they were implemented in different times for different purpo=
ses.
> They were merged into MPTCP repo on May 17 for "run MPTCP sched tests in =
a
> dedicated ns" [1].

since they were sent to a different tree than don't send them here.
git will not like that during the merge window.
