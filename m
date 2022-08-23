Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9F2913
	for <mptcp@lists.linux.dev>; Tue, 23 Aug 2022 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661270051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7G2Tle4U0Lcc3NJ+Zxfqo56z/wwKBD1EA2KqAiKHkY=;
	b=Ka+OS6AuqQvMpMr2GE9iqdV2Y3GUeiQu5GZF0xLppIeJbGjHBnOn3PpsNObQ3IyLXOmcfx
	ViP5lRG2mnaBeUJJooX9/pjHy4lte1guSKADTAV5f9ECcUyugu7zxzrdGb6bd9bpXAhKnT
	5GY+uJ0LFV267NVWG/bTF5XAWfI7cOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-COFRRWPGPFSei1mx7SY0Zw-1; Tue, 23 Aug 2022 11:54:10 -0400
X-MC-Unique: COFRRWPGPFSei1mx7SY0Zw-1
Received: by mail-wr1-f72.google.com with SMTP id s20-20020adfbc14000000b002252dae05f7so2353046wrg.20
        for <mptcp@lists.linux.dev>; Tue, 23 Aug 2022 08:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=S7G2Tle4U0Lcc3NJ+Zxfqo56z/wwKBD1EA2KqAiKHkY=;
        b=TnBYdkRSCKEzsdYZ4UWaS2UCvNG71y5hnO88yNY8Egp1lACqCrQ8ybz2NCLjCapk21
         WYs7mWVcrFF7FPusTrWkgWrdbrcPnFbKvqqKhZq7LlmIe1N50eHuobwTNfE3A8h9KBKX
         Db2mzkbknJStZqKixPNHcLpXnNR6A5n6VGLu21bwk3fUzPWU/BdnkWKpbRvGDCkkAyq7
         z3kxE+ZR5aUc6qt8COKkpOy7HbAy6/BXus4QvbNwh4RwxnS6MAwIGVjVMC9lA+B2N7n8
         aldI6i2MR4s2LNRlPWpAbdnYoSOBd6yln03pOShYqxbWoS0yNNJVnruXgPn+2sjB+iGt
         aSXA==
X-Gm-Message-State: ACgBeo3e+qva3nX6m9iEdsT2sgyZ88IG5WWnWeN3ZR7By0U7vWO7DfaQ
	uEimBvZwT7Nd/IvQOTaYAaOFStnjEwkETmGn0RIzOr1C6FkZeTf/IW25Aa5fgpXe1+woYiChCET
	MeKDmqd/RwMWcdjU=
X-Received: by 2002:a7b:c38e:0:b0:3a5:c383:c68 with SMTP id s14-20020a7bc38e000000b003a5c3830c68mr2584587wmj.163.1661270048870;
        Tue, 23 Aug 2022 08:54:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6yJQdc7HoJtg2BV7Iu4ag0kVdknoIMZNuLT1rVotBbChzedLLkNR7Sywjj+lsIb0ofU2oRVA==
X-Received: by 2002:a7b:c38e:0:b0:3a5:c383:c68 with SMTP id s14-20020a7bc38e000000b003a5c3830c68mr2584577wmj.163.1661270048539;
        Tue, 23 Aug 2022 08:54:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm19661359wmq.36.2022.08.23.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:54:07 -0700 (PDT)
Message-ID: <81a5905caefa01f2319553805119c5b0eff2d864.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2
 when mptcp has unacked data_fin
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Tue, 23 Aug 2022 17:54:07 +0200
In-Reply-To: <20220822123206.GF11586@breakpoint.cc>
References: <20220818162123.30198-1-fw@strlen.de>
	 <09c08d1262325db726f2d3d2d6e4efd351612a87.camel@redhat.com>
	 <20220822123206.GF11586@breakpoint.cc>
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

Hello,

sharing here private discussion to keep all on the same page...

On Mon, 2022-08-22 at 14:32 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > > Full test case stashed here for the time being:
> > > https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> > > 
> > > Its possible to either change tw_sk to have enough mptcp context to be
> > > able to send a packet back, or we can supress/delay the tw_sock
> > > transition.  This is what classic TCP is doing when it receives another
> > > FIN while in FIN1 state.
> > > 
> > > This change makes the test case work (another dss ack is sent), but
> > > there may be other corner cases where we need to delay the sk ->
> > > tw_sk transition.
> > > 
> > > If the general idea looks ok, perhaps its better to replace
> > > 
> > > tcp_time_wait(sk, skb, ..
> > > 
> > > with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
> > > and place the option parsing for mptcp-subflows there?
> > 
> > _if_ (big if) I read correctly, this patch "always" (most common
> > shutdown sequence should match the condition checked here, right?)
> 
> Really?  I had to fudge with the test case a long time to get the needed
> transition, I'm not even sure the test case is legit.
> 
> https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> 
> is that even correct?!

I mean/fear that a simple shutdown sequence (local close(), followed by
remote data fin) could end-up matching the test implemented by this
patch (even if the data fin retransmission will really happen on a much
more rare condition). 

That is, possibly the test is a little more relaxed then actual packet
sequence necessary to trigger the issue (but I don't know how to make
it more strict). 

I'll try to double check the above.

Thanks!

Paolo

