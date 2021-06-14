Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E82FB8
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623667175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkHxYEIkg7Og+gUMxSohhO0XY1IfsFH7N+LC9E1gFcg=;
	b=A/lwaPyxtwp1ZnIyNJGaxUV8ia8M3pge0ZDTIuuiL8HZayP4zlJAV9gppY0Na3qAs5A15h
	icOfD9dmf4B5+E0lA6qRc5XwO0ihbkEFDpm8IznFVD4aoszCYgpLI0x41Z/0ieDg/H59az
	ZobZmNlFM0XCFrQxV7iEIFXSCmN1TL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-v95smuj1NBaC7X63Q17b0Q-1; Mon, 14 Jun 2021 06:39:34 -0400
X-MC-Unique: v95smuj1NBaC7X63Q17b0Q-1
Received: by mail-wr1-f69.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so6840227wrq.18
        for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 03:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vkHxYEIkg7Og+gUMxSohhO0XY1IfsFH7N+LC9E1gFcg=;
        b=I1u2PgYKOEdh2JJXND20N1W6pAFH5OC66jehw8q8I4+OzB8k+xz+L8IBBmtbIWNwG2
         e33paNGjmjAMQlsHBoXj1DhJ3u/v5dYkqu06GU6aeLlxy98jQQP28jNHiOjjjnZSSKwh
         nOzvsKShfFChiYRZB1pMXTW7n562ZJlQMdJwcZszyVBIh8AVLfoZ2YjmN9X3fWCmhEn9
         X9S/KbBuQQ7Aw+u1uSXm9SfOVq3jLVCwsufky9ORxAjN/CLOrIALFyrSROpzkqPrTw9U
         s8SzGkP5wKNSx2JieoiLG8IzpMWEi4G1lgI6CX/oUP4TKl9njeTwAKUXDP+2DMNozxY1
         9K9g==
X-Gm-Message-State: AOAM5332mmXSP+4Y6xFQtcpGXpNrwNzo+i43meHHZH0AowwRFOWxyCWM
	qLD0hVN2NQfeHC0NdqOLhDpJTWaH99v3RoyqLlKcYaUkT5eems7dJtn8d5HD/jB+ldPdgVF72An
	/vOZxx+zTb3q+6p4=
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr15835431wmn.166.1623667173288;
        Mon, 14 Jun 2021 03:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8qU1UnfSjk8uKMOBtEdWrGVbmWl4Q3h139XZxHGiLb/VUsTe50bd9i6FFUCkt8e247UQG+g==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr15835417wmn.166.1623667173047;
        Mon, 14 Jun 2021 03:39:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id b8sm20290154wmd.35.2021.06.14.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:39:32 -0700 (PDT)
Message-ID: <eb41332a032c3c8191ce6b0d0ce2d2aa93ad5081.camel@redhat.com>
Subject: Re: Checksum support: default behaviour
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Mon, 14 Jun 2021 12:39:31 +0200
In-Reply-To: <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
References: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
	 <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Fri, 2021-06-11 at 21:05 -0700, Mat Martineau wrote:
> On Fri, 11 Jun 2021, Matthieu Baerts wrote:
> 
> > Hello,
> > 
> > With the current checksum support series from Geliang and Paolo
> > available in our tree, the default behaviour is not to use this checksum
> > feature.
> > 
> > Should we eventually do the opposite and have it enabled by default?
> > 
> > I do understand this has a cost in terms of performances but this could
> > help detecting nasty middleboxes, i.e. the ones that modify the TCP
> > packets without modifying MPTCP options if needed.
> > 
> > On the other hand, I don't have numbers showing if these middleboxes are
> > rare or not.
> > 
> > But also, the main issue I see if we enable the checksum support by
> > default is that we are no longer able to talk to servers not supporting
> > it (<5.13), no?
> > 
> > WDYT?
> > 
> 
> I lean toward leaving checksums off by default, based on what I've heard 
> from community members. It sounds like large deployments haven't seen 
> checksums catch many problems? Some actual data about the frequency of 
> checksum failures would really help.

+1 on keeping csum disabled by default until we have at least one of
- performance data (delta)
- impact proof (csum corruption in the wild)
  (side note: even with no middle boxes at all, no app-layer mangling,
we can have bad MPTCP csum with correct TCP csum, e.g. due to BER plus
bad luck causing a stream corruption not catched by TCP csum but
catched by the MPTCP csum).

/P

