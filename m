Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35928110D
	for <mptcp@lists.linux.dev>; Fri,  2 Sep 2022 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662110234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS56xy3n9hcEgLTZK6YFilmjQHLw5ounT5XOMzWKUCE=;
	b=L2EfWdgytpPqNNLDSwSUj75yzZYToe3RnccHK1V0WEgesvrcu9HIZXgS8j9CI+fsCgDVlU
	t4CvxN5pKupeD7XL0OYIyLz5DibcfnVxZwyhtd5ZZtM9zrTT4dLhNiVqFguMzdxAK1Z+4d
	IQmxpWDUsUyhaWFFf8hEAWfbh1LfmJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-mcZoLuTdPIuML-f-VsBHIg-1; Fri, 02 Sep 2022 05:17:13 -0400
X-MC-Unique: mcZoLuTdPIuML-f-VsBHIg-1
Received: by mail-wm1-f71.google.com with SMTP id p19-20020a05600c1d9300b003a5c3141365so2666183wms.9
        for <mptcp@lists.linux.dev>; Fri, 02 Sep 2022 02:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LS56xy3n9hcEgLTZK6YFilmjQHLw5ounT5XOMzWKUCE=;
        b=whkAUc8B19CKGCTVnnVdzvFIk2uKo1rgPVffCbSQ2GWx0MVDbw35yfdqQXFqiUTdU+
         +bwmM4l2Jet9d8kfPJz7S9iKWj8fnnkFpheQBh/1GQnIElRefM5vxURkwUfwlnlCSof0
         Vmkvd2cc5tEYzCCMfaIPkJ7nmBICTT3W9tPI3S+o3dW0vLFzyz5E1mc9+xowFeFOUFxj
         aNHYOBboTxFYG2LohK26Kkx2+Zwto3UbFdJAb4JM38Wux8oXlujFVaryvwq+8AWggqTc
         mx3tawsDIUhip9geBIUU/byaz+q2ZlQDs7KCYgZKmDkI9WMJtLEDuSABCiWtX9OLYggm
         FCHw==
X-Gm-Message-State: ACgBeo2EuJfVyjIeacg75WB9F23/oNKInoEhZcM3RLzB8rncidgpFUNi
	tZFaVsH6vDreOqrF/aXiPLpIhkxJD11eRZScCG1Djn569WKkcmWZZs/r+/MjhecYaRsmYhJSJPw
	f+SImdtCJ6gCMGXw=
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr2135289wmq.188.1662110231803;
        Fri, 02 Sep 2022 02:17:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR569yuNByZPyIeMyXXEUO8Ei/zWE77AYTAwjP0Cq74rTM+psLLi4zh1lQmcE/T0h0lrqUE0OQ==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr2135273wmq.188.1662110231491;
        Fri, 02 Sep 2022 02:17:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600001c600b00226d2462b32sm1005644wrx.52.2022.09.02.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:17:10 -0700 (PDT)
Message-ID: <f3acf69cdc24399645b4d722fd5426d8e123b588.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2
 when mptcp has unacked data_fin
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Fri, 02 Sep 2022 11:17:09 +0200
In-Reply-To: <81a5905caefa01f2319553805119c5b0eff2d864.camel@redhat.com>
References: <20220818162123.30198-1-fw@strlen.de>
	 <09c08d1262325db726f2d3d2d6e4efd351612a87.camel@redhat.com>
	 <20220822123206.GF11586@breakpoint.cc>
	 <81a5905caefa01f2319553805119c5b0eff2d864.camel@redhat.com>
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
Content-Transfer-Encoding: 8bit

On Tue, 2022-08-23 at 17:54 +0200, Paolo Abeni wrote:
> On Mon, 2022-08-22 at 14:32 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni@redhat.com> wrote:
> > > > Full test case stashed here for the time being:
> > > > https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> > > > 
> > > > Its possible to either change tw_sk to have enough mptcp context to be
> > > > able to send a packet back, or we can supress/delay the tw_sock
> > > > transition.  This is what classic TCP is doing when it receives another
> > > > FIN while in FIN1 state.
> > > > 
> > > > This change makes the test case work (another dss ack is sent), but
> > > > there may be other corner cases where we need to delay the sk ->
> > > > tw_sk transition.
> > > > 
> > > > If the general idea looks ok, perhaps its better to replace
> > > > 
> > > > tcp_time_wait(sk, skb, ..
> > > > 
> > > > with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
> > > > and place the option parsing for mptcp-subflows there?
> > > 
> > > _if_ (big if) I read correctly, this patch "always" (most common
> > > shutdown sequence should match the condition checked here, right?)
> > 
> > Really?  I had to fudge with the test case a long time to get the needed
> > transition, I'm not even sure the test case is legit.
> > 
> > https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> > 
> > is that even correct?!
> 
> I mean/fear that a simple shutdown sequence (local close(), followed by
> remote data fin) could end-up matching the test implemented by this
> patch (even if the data fin retransmission will really happen on a much
> more rare condition). 
> 
> That is, possibly the test is a little more relaxed then actual packet
> sequence necessary to trigger the issue (but I don't know how to make
> it more strict). 
> 
> I'll try to double check the above.

I'm sorry for the latency. I reviewed the relevant code, and I now
think the new code introduced by this patch will not trigger frequently
(at all) as I feared above, so it should be safe.

Additionally I reviewed the relevant pkt drill, and I think the
scenario addressed here is really a "strange" one, e.g. the remote peer
must ack a TCP fin without "accepting" the MPTCP-level DSS ack carried
by such packet. (because it retransmits the acked set/data_fin). I read
the above as esplicitly forbidden by the protocol.

According to the RFC, the mptcp impl. must not drop an accepted TCP
packet while processing it at the MPTCP level. While that may be
technically hard to enforce for packet carrying data (e.g. due to mem
accounting) it looks easy for pure-ack, as in the above case. So the
buggy implementation has no excuses ;)

TL;DR: I think the patch is good but likely not needed, sorry.

Thanks,

Paolo

p.s. the test drill contains another "strange" thing: the client mptcp-
level data ack sequence moves back from 3 to 2 (line 30-38
in https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d
) but that should not have any effect, as we can move the received dack
seq only forward.

