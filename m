Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E970
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 07:31:03 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id h1so10643293plf.6
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4oHUcki0YuieCHHOiqu+m6mr+i1/1tmce0L+2duPpkc=;
        b=rnjFWcUXcNdhj3eCP6eUU9mqieoBRYNzrIrLusy8VVnZnsRrF5tgLQ7hAHl6OgVfT+
         j0SD7XNewun6dDuVUPURz4xB4cJ7fly7dH1CF1bVGk+WXVhE6Jm07yoJEr58JEn3JNPG
         wwyJlSAkbD71IUflyTaP/gc62npa6C+bBj5HPk4CQPwjFjQ7L3H41+7HxUWBPCtkbn1W
         XjErRaZC8etiuzQc8MEwkkQPFpLxJ8LVmgnE+xNt3D7K+CHSJtKfefKx63yJWEEjlfxz
         fuJ4t7x1GOT0uGUfuHKRv7FPosxc9Eil1fNCIWQ1STUuxLcw55LFuOY89AXsC+bITpqw
         3B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4oHUcki0YuieCHHOiqu+m6mr+i1/1tmce0L+2duPpkc=;
        b=q/A+X2GYKjRqe37ek1yKk5wPtgL4gQ2J5WL6GmwfSUTwf7fJO73mqGAnCY52i/SHlj
         pn2WH852/ktXo1DAI3FEFq5UhZ0KzNeEQyOIYjiWylBoaUWm4T3pE1rN+7LOvyqFCZYN
         FReADztxbOHptoMXwlFOi9i87Uhl6Zd0ICDYRoFvG0lEpypfws3IBaEyzegWjb9Ly5j6
         DBu8z44qlFVDgckJYvT1dS3AcS0MNPMbDwQNm5ckB3rO/ADqfqizkrz+14fRVOlPFlwd
         +XSJV2IWE7i+x4eceK2sKE/VvgYXIZURTLYDmpDgwP21VSNS8j4nADlgL4pHYpKnGlKT
         xdfw==
X-Gm-Message-State: AOAM530z0Z3w+LXGCrIpQmcWtEcwhSILghFirKPhOI/EaxU+EXxKgJk2
	pX4x/S8DqQG5kqrPMfuOhaGO3eLYZBMEylynG5XxGsEE8+rYXg==
X-Google-Smtp-Source: ABdhPJx8r7weBhn9/BFkuXpvkWtpsYDhiDZ57ZihCAGqBqyjCavqXbDFYXdxmz//ZvtNAtIK0ilUnow1vGoDQeKAsRc=
X-Received: by 2002:a17:90a:4bcb:: with SMTP id u11mr18236236pjl.6.1626161462899;
 Tue, 13 Jul 2021 00:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
In-Reply-To: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 13 Jul 2021 15:30:51 +0800
Message-ID: <CA+WQbwsAbBmWYAbaWfHiM=q_OkU5jrFa=40wueKn6=GQ+WOppQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: fix ADD_ADDR and
 RM_ADDR maybe flush addr_signal each other"
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This squash-to patch will conflict with "mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal":

Auto-merging net/mptcp/pm.c
CONFLICT (content): Merge conflict in net/mptcp/pm.c
error: could not apply 205974fb3505... mptcp: build
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal

Please fix it like this:

 <<<<<<< HEAD
         *saddr = msk->pm.local;
         if (*echo)
                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 =======
         if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
                 WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal &
~BIT(MPTCP_ADD_ADDR_ECHO));
 >>>>>>> 205974fb3505 (mptcp: build ADD_ADDR/echo-ADD_ADDR option
according pm.add_signal)
         else
                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);

->

         *saddr = msk->pm.local;
         if (*echo)
                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
         else
                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
