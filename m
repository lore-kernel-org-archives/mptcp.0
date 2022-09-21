Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B33D4
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 13:38:03 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id h194so5027460iof.4
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=PiTRNgCdEwz+MCFlo3fTmA1CFCG/E35e6Hvc9DA/uRs=;
        b=JEBh4p/QFj5HfcaYOUBzW6DKjPvCBc51toLZFm2yfAQM7x+Gke+jiwp7PAPqyojnjf
         Rg65c+5NJgLAzcDRv85sHeA0i0GAeY1DhuKbBvziF7O53OJihFkPjX3DS27xYbY52Ptz
         GnqpltxD3fUA12iIov4Q3k0jkv63pfSuBQceX2M3yQnxClCshGavgXWnQD9GPUgvd9Bw
         YKErujCwZpseyPKmtZCsBrLcNDo8wRbJ0kt9NFh99crYC1UVQH7GKK7QqMEePU8Ab4tR
         Sa6MNsBu7vofUZr12qabSATmDaGGoB7/gRgxhhn07HBkPFHwCDTQuz39/8T0W9qmkl2V
         f5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=PiTRNgCdEwz+MCFlo3fTmA1CFCG/E35e6Hvc9DA/uRs=;
        b=Oi+KI6H3aoxpgZzrJW/mPqirPVRcSnwGkriz1MJycFNKj9RkoKF2ZCcWorqJBOOiOx
         E8fEqct7NlH7lPMZW/ATgB04yPbkpcI0JyP8LfZ6xhY+Jyfhnb4qJtKUxtGrRm8ZLdMP
         1es3pZeZ+a7O7xaTItMMIN/yvdFlGsuQowppADmIlTi5trgvFjzrAhskbejAN0xeocNL
         UgwZsOiVJNfIT75kXHGhFnVk1yHJQZOjfMkDwIOyLUwJ2i4hnWezAvIUa6Pg4S+8KHYq
         wydmf6CXDu3qxj7rnQpfm1jZAWOKPgC7aP3ZabqzDnQwnTpItslNKJoLSp0lsgxYccGj
         45bA==
X-Gm-Message-State: ACrzQf2/OJPotD0EVKNDePLOaeobxAd9vbi8D7fMwMLLUsMJUs8ESF5J
	t3aY6odMG2TSmEez6V8N3Gf1yqADMcbK
X-Google-Smtp-Source: AMsMyM5qAZO9IUe+BjWrQViWPen4OgNfSXwn4Z6oT9JwSU5Rw4GEWk34o68xNP4v5nDPB913kLBxag==
X-Received: by 2002:a05:6638:16d6:b0:358:31d8:65d8 with SMTP id g22-20020a05663816d600b0035831d865d8mr13888622jat.137.1663767482356;
        Wed, 21 Sep 2022 06:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.220.166])
        by smtp.gmail.com with ESMTPSA id k10-20020a6bba0a000000b006a19152b3f0sm1218868iof.5.2022.09.21.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:38:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220921125558.19483-7-dmytro@shytyi.net>
References: <20220921125558.19483-7-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Build Failure
Message-ID: <daf00e8f-c5bb-c518-18ef-9093848847b1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 13:38:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220921125558.19483-7-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3098139757

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5eb61bb88e80

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
