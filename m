Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CE3FC7
	for <mptcp@lists.linux.dev>; Mon, 27 Sep 2021 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632730559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOXnhLBubBGTJ+saj6Tv88lQ1Psl3I1X1D5Yr8z8ToQ=;
	b=VRTroFDVxnyORSj6A91dC3gSmqD7t+dwyhM2FmiPAmC0VKCBWhI6ms8Z0Bi4M5CV5m7krz
	GVD2hmORXbN/7PhBxIhLA2h+VEbpTdo1sg0Af69UjLUmSsVQlo8+EJcTVU2UFDKNzwiGiS
	aEDDYKBYNAtsK7q2wOeDEoTuPtqPweE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-voMcILwHN9SYwu3cucIjvw-1; Mon, 27 Sep 2021 04:15:57 -0400
X-MC-Unique: voMcILwHN9SYwu3cucIjvw-1
Received: by mail-wr1-f72.google.com with SMTP id a17-20020adfed11000000b00160525e875aso6104201wro.23
        for <mptcp@lists.linux.dev>; Mon, 27 Sep 2021 01:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FOXnhLBubBGTJ+saj6Tv88lQ1Psl3I1X1D5Yr8z8ToQ=;
        b=zQKYT51BCvCOk83ewyZXeg2+E0QJ9AzEWTP7tRAj6dAc5s+KaLRpfKbgzH98IKw7xb
         V3rKGQBwnHZcBjJ9INDcWcJYkuajdsWflYuU4J/Li/jOvpHp7ojo14wS7BwpXOZ2Ympr
         THVVQKW8J077s6+P13sFIzJvkXx4symJ5OzukGyoq9bx9SGqMMyv0n1uXdJrrQhG7urF
         Ofsw7xwjSTw35rhMM7k5O3CZNN3pucNQwb1v+A1fByHraAs0J6vTJgCMYtsE8c6u0Y4Q
         M+bNCMlSN1Q8POwUA6i9UKrM+CpOr39Hi2ycVvZDazdRFRW5DGmt963uRycInQcbjrBB
         XK2g==
X-Gm-Message-State: AOAM530PKYq7r3PpJFRlbfEBMnocD5PAjdDsby9vqVGQZeoVFyvla6SN
	8M445ZKfptTSTAhEGkgCA5qliMpy5u5n4MUmXeRvvW0ZH8uMb2A4rLjQmg0euK9wQoIozQu1xiX
	ffOsQ6qjNOUqqnzc=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr25975434wrs.316.1632730556449;
        Mon, 27 Sep 2021 01:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1tbzbGG9xwVNkyem1no9h8O1rReArGUjjl63nf3FveYU7VC0mKqQT6TmxeqL50vqY8+2nfA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr25975419wrs.316.1632730556227;
        Mon, 27 Sep 2021 01:15:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-101-84.dyn.eolo.it. [146.241.101.84])
        by smtp.gmail.com with ESMTPSA id u14sm14226251wml.24.2021.09.27.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 01:15:55 -0700 (PDT)
Message-ID: <e4f697a4da0dd4f0c063792c12f2d8e4d5a01ebd.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net] net: introduce and use
 lock_sock_fast_nested()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 27 Sep 2021 10:15:52 +0200
In-Reply-To: <6485e648-1038-736e-4da6-c513efb21ebf@linux.intel.com>
References: <46317e271da725006df9916b2b2c3d334d3616e1.1632490917.git.pabeni@redhat.com>
	 <6485e648-1038-736e-4da6-c513efb21ebf@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-24 at 11:51 -0700, Mat Martineau wrote:
> On Fri, 24 Sep 2021, Paolo Abeni wrote:
> 
> > Syzkaller reported a false positive deadlock involving
> > the nl socket lock and the subflow socket lock:
> > 
> 
> ...
> 
> > the problem originates from uncorrect lock annotation in the mptcp
> > code and is only visible since commit 2dcb96bacce3 ("net: core: Correct
> > the sock::sk_lock.owned lockdep annotations"), but is present since
> > the port-based endpoint support initial implementation.
> > 
> > This patch addresses the issue introducing a nested variant of
> > lock_sock_fast() and using it in the relevant code path.
> > 
> > Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> > Fixes: 2dcb96bacce3 ("net: core: Correct the sock::sk_lock.owned lockdep annotations")
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-and-tested-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> > - fix a typo into a comment (Mat)
> 
> Thanks for the v2 and the answers about inline functions vs. exported 
> symbols.
> 
> Ok with me to merge in the export branch and/or upstream. I'm guessing you 
> might want to send this one to netdev yourself?

I'm fine doing that. I'll send it after somo more staging into the
export branch.

Thanks!

Paolo

