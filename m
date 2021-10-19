Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7072
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 08:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634632144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1aBBMLVwHSM/B/hGkBU/qDzznaQLZCwy1PF0ddizSw=;
	b=Lm4ozGD70JYsnAmYXhFZ+9yNP+U6Aw0IF04D3Nyk6Vzz8TaorZGUTAmCqgSKqkMSptBZBr
	Ule8EZopS4LXBMdevrmoSQWkzwpkBISzC6Tag8v5PDL1AHiXz7ADnBEKcsa6dUCaN8i8N/
	4+TyK1SEWIrE3+qd9ACK9pN7qfPGF28=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-yg1TazYzP_q5Fzx74ZKqNQ-1; Tue, 19 Oct 2021 04:29:03 -0400
X-MC-Unique: yg1TazYzP_q5Fzx74ZKqNQ-1
Received: by mail-ed1-f71.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so13400997edx.3
        for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 01:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U1aBBMLVwHSM/B/hGkBU/qDzznaQLZCwy1PF0ddizSw=;
        b=L/xy9pB0jsXwvIaAQhyD0Nna12cLLawa2BFTUzwIXxHMjtqt8Z40b8ES5Xw/tNlG45
         dIAk+WWJPiMhCqv69GYSYh2Qw9VQnVslfMGPeAfJFkzmCX4jjNXGen/zStbaCjujR9Fe
         Wuh9y9dAFmDm2nE8pmaVKUtAnovWeqwqo98aiVgpr5wNtxCwD5YzsBdOLUstCFz9yRLA
         e0GNRne2OplBiG3kGlTfjQ1dJ0o5rA7bSLCjfhKaFEdWfAJnGPDnICeMkchHekfCCVrd
         ZUJDQtRgihkHRBCgHtHIdZOfEdup2hG4Cu5z2gNcfmx+//dzhYLYvu5AP7gfxRev3wAS
         WRBw==
X-Gm-Message-State: AOAM53030idxwXZAzKiygkTKVkb+iBggPoxcmU2oAvV/rQWUSTA/SYC+
	mWIrBh6JPmPwxrWqJHm2Y5GUhidnK5MmnkfWfHiqmhGNOSriSzaLIusmqC9ab6sJCt1b644OjCZ
	MzUdqfXiZaWPbh1I=
X-Received: by 2002:a17:906:bc43:: with SMTP id s3mr36257713ejv.46.1634632141633;
        Tue, 19 Oct 2021 01:29:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl7BSR3T76Jd/0QU/9IIUfdNjSKQVFjZU78t2nuvHr/K0jqBOtzYTQqRUkivOZewjPWCd6Qw==
X-Received: by 2002:a17:906:bc43:: with SMTP id s3mr36257704ejv.46.1634632141504;
        Tue, 19 Oct 2021 01:29:01 -0700 (PDT)
Received: from localhost (net-188-218-17-84.cust.vodafonedsl.it. [188.218.17.84])
        by smtp.gmail.com with ESMTPSA id e7sm12040189edk.3.2021.10.19.01.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 01:29:00 -0700 (PDT)
Date: Tue, 19 Oct 2021 10:29:00 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Geliang Tang <geliang.tang@suse.com>,
	MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Message-ID: <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 18, 2021 at 11:03:13PM -0400, Geliang Tang wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年10月18日周一 下午8:50写道：
> >
> > On Mon, 18 Oct 2021, Geliang Tang wrote:
> >
 
> Hi Davide,
> 
> Could you please share your test script to me? I'll try to use it to
> write a new selttest.

I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
bit in the TCP header, I promised myself to change it to corrupt the DSS option.
The problem with this approach is, we can't assume that the DSS option has a fixed
offset from the IP header. So, the test might start corrupting other options that
are not MPTCP. Maybe using eBPF, using something like what Matteo did in the
past [1], we have more luck ? 


[1] https://developers.redhat.com/blog/2018/12/03/network-debugging-with-ebpf#how_ebpf_can_help



-- 
davide

