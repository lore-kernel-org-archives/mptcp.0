Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0F168
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626887293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76kNAZCpH3YQhwct+BdhEHlqtkU9I0TgumQLXRnB/EU=;
	b=V61rErY2D14Tltcuz+qL/iRc93c/AwWQTUhTMOxPlzZRcJE1pwOIE7xLH34iuRt08RoLOU
	ES02Wx4S5d0Xnw0ENIyeObAQJOkE7m9lSQVlJVWPIyxLm7kL5Is2jbmAOlzhgP5YKYL5yl
	S3gvimJpIkP92qnbwBz6BkcsfRSwl3o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-GffJrGqiN-uGbzWtmX_iww-1; Wed, 21 Jul 2021 13:08:12 -0400
X-MC-Unique: GffJrGqiN-uGbzWtmX_iww-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so1287356wrs.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 10:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=76kNAZCpH3YQhwct+BdhEHlqtkU9I0TgumQLXRnB/EU=;
        b=LATLTG1ofhPeBuJ9cAbSDDnUaDyalJScZTgIC+JzGT9fU4fYPlqjrgB1ycA5GMqvf5
         iDEEIOBSHpaTi5Q+zsHZ4uxGy6UFIQUgFnYTJml/4D50UX/N1ut3y9swhKXlughV7hvl
         UV8uM9wyNDepv6YWCmRP8gz1Weuq4pVP8ZfoIUE1O1TjEzpKs8UiWjvCGgDs2zvy5r47
         1z0qw0ZYYmyYbqQKojEgMAFf1FaidHHTS2BpvkC1Bv5ER808gL9oqnSCYq3V/JLFV/2H
         yq9IMKL+EykO1eteU/Eup9oOnThmTzoKls0Ja2AcV/6y9qVJwNeT+X2pPat0HvawHWRA
         tMPw==
X-Gm-Message-State: AOAM5327kT1s/H2rn+CXLLQYA5Pn9M1wBB7LiyYabDGH13IHsDOPZ/Zc
	FGEW2WZD+OYoe2skq44esgfe1MiqEdzrc5LsfKK3TXUFsOjsSi1hV7NRbNNjW0bWZcAVjPdjx/+
	WhCjf9XdBmpQR8P8=
X-Received: by 2002:a05:600c:3786:: with SMTP id o6mr5062988wmr.155.1626887291435;
        Wed, 21 Jul 2021 10:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMGAKeNQvR4/aQirYGLOj10WZr6ASOK1kLTv+WPT5rKD1TOlkWkvuDM1B7MotkU7ZfemjfLQ==
X-Received: by 2002:a05:600c:3786:: with SMTP id o6mr5062970wmr.155.1626887291251;
        Wed, 21 Jul 2021 10:08:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id d15sm27725339wri.39.2021.07.21.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:08:10 -0700 (PDT)
Message-ID: <9e1a6fe0df035c74c7f9169a89a3e4de0954f040.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: register ipv4 addr
 notifier
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Wed, 21 Jul 2021 19:08:09 +0200
In-Reply-To: <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com>
	 <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com>
	 <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com>
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

On Wed, 2021-07-21 at 22:31 +0800, Geliang Tang wrote:
> This patch added a new file pm_fullmesh.c, and modify Makefile and
> Kconfig to support it.
> 
> Implemented a new function mptcp_pm_fm_init(). In it registered a ipv4
> addr notifier, named mptcp_pm_addr4_notifier, to deal with the events
> of net device UP, DOWN and CHANGE, and skip the loopback device.

Do we absolutely need these notifiers? can we use instead e.g.
NetworkManager scrips to create/delete endpoints as needed ?!?

/P

