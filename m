Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622AAD5E
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668525761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgMuQu1A43xXfHB4gj+l+vCNqoLalLqOFWxi/TvDXos=;
	b=DwsfiHbcnbcWwZDJjFzqSLPe8sgiHJ3AolaDtKmHl+QQGcxKiB0EDZpVbDz4XHaIdLI8Dt
	nPDc3W0SAoXYQsXRQjMKGmT+g3egmnkkEubHakoMgrN45pF1IN3F4TCiHLLhXUVvyAdTfp
	ctOLuGbfXAc2Ht0qVoN0leFxFX7HWbY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-gs3bFhHAN7iBE5JU51uO2Q-1; Tue, 15 Nov 2022 10:22:40 -0500
X-MC-Unique: gs3bFhHAN7iBE5JU51uO2Q-1
Received: by mail-qv1-f72.google.com with SMTP id l6-20020ad44446000000b004bb60364075so10905452qvt.13
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 07:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgMuQu1A43xXfHB4gj+l+vCNqoLalLqOFWxi/TvDXos=;
        b=otdKtKRROd/iaRTohkFhh9FI+NaaSbQtumt7BYzRLPFXZb3lk9qL0i9wY/5ej55G2H
         XQ7NZulkmpRqyu5kAmyOgM7iry2ZzN0ffTsWQvR5Z3svvJ9gbr8N6RzY5AIWwOLcEAt9
         7P01rO/3Ffl+8v0sfimSoXEJsIJtbFNOv1Qhop78QvUdBYdDWXSbFqwgHQ7MOWUcJ5v1
         8Lv3Piq0xZyjGgQq4DEp8rD512lSnJ9Dj7I42o6PE7qid63n2eGnuXbIjMymcAnPRwmY
         /NbQaIUZaZKjsW4QeXwe6UeMSHVn0elHxIOTaIS3T7CWTM0+joVWUHazVDpUKzNhufMP
         2Qlg==
X-Gm-Message-State: ANoB5pnL1B/u+JSZH4kYCWkGesAAJ80bpcoqkrPwHPMeACTO7LiVT4H1
	RczdxUi4VlXGNCIDYk4/fAMtGgZbBp7T7qegbpwbGVaeHI+yt7h3sgnfsnHAxpMKmYRFwL+y7cm
	6edH1lyFwCk+b2q4=
X-Received: by 2002:a05:6214:3481:b0:4bc:176f:a50a with SMTP id mr1-20020a056214348100b004bc176fa50amr17680728qvb.25.1668525759899;
        Tue, 15 Nov 2022 07:22:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4IkZWp3RoD6Ry2J/NniABqM0eBP+YNasIM/Luid7lMOHrMD43gVgIUgtZyqf0aWWNuaczqLQ==
X-Received: by 2002:a05:6214:3481:b0:4bc:176f:a50a with SMTP id mr1-20020a056214348100b004bc176fa50amr17680703qvb.25.1668525759548;
        Tue, 15 Nov 2022 07:22:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006cdd0939ffbsm8396612qko.86.2022.11.15.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:22:38 -0800 (PST)
Message-ID: <d50628e44e6e6f8a6bc3e7150b027193cc3f45c5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Date: Tue, 15 Nov 2022 16:22:36 +0100
In-Reply-To: <f79c0855-7458-1e63-49fc-10b3168911b3@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
	 <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
	 <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
	 <f79c0855-7458-1e63-49fc-10b3168911b3@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-11-14 at 18:11 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 14/11/2022 18:08, Paolo Abeni wrote:
> > On Mon, 2022-11-14 at 17:58 +0100, Matthieu Baerts wrote:
> > > Hello,
> > > 
> > > On 14/11/2022 17:45, Matthieu Baerts wrote:
> > > > Just some small quick fixes about "issues" I saw when I applied the patches last
> > > > week. Nothing important: function names, place in the .h and small checkpatch
> > > > splats.
> > > 
> > > An additional thing to do is to update the commit message of the first
> > > patch of the "TFO listener" series which is currently:
> > > 
> > >   mptcp: introduce MSG_FASTOPEN flag
> > > 
> > >   In the following patches we will analyse the MSG_FASTOPEN flag
> > >   in the mptcp_sendmsg() and invoke the MPTFO.
> > > 
> > > Maybe by:
> > > 
> > >   mptcp: add MSG_FASTOPEN sendmsg flag support
> > > 
> > >   Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") from
> > >   Paolo Abeni, all the infrastructure is now in place to support this
> > >   flag.
> > > 
> > >   The remaining action to do is to allow it and treat it as a fastopen
> > >   message to be able to access this:
> > > 
> > >     sendto(sockfd, ..., ..., MSG_FASTOPEN, ..., ...);
> > > 
> > > What do you think?
> > 
> > Possibly something a little less verbose? Alike:
> > 
> > """
> > mptcp: add MSG_FASTOPEN sendmsg flag support
> > 
> > Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") all the
> > infrastructure is now in place to support the MSG_FASTOPEN flag, we
> > just need to call into the fastopen path in mptcp_sendmsg()
> > """
> 
> I know you would prefer a version without your name :-)
> 
> Sure, it is good to me!
> 
> Is it OK for you if I do the modifications and apply the 5 other small
> patches? (no hurry :) )

[browsers!] Sure, please go ahead. I have a couple of additional
fastopen follow-ups pending...

/P

