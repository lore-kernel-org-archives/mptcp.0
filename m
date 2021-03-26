Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFE70
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616752766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD7WvpGG7IxvncRsnKLkKl1ftLBUzfwlgWpNxp0VqXY=;
	b=apXbbYNVstq8szBBavIuB8D25V2qL23jQ/S2UmlkDhzy0B3y+2bCB1uCrVb8nlgCrxXWzq
	XV3zAnEeA7BSOp4KWUjK/Oe2Yv5PKcB/f7meJqsQ3l/o7R10vxo1/98yhtn5JSl6jK1mxQ
	4MKBS7UvrQ85d7Yq3voEcD9Vmo38UfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Im9jfn8kOm-bZYFm0FLY6Q-1; Fri, 26 Mar 2021 05:59:22 -0400
X-MC-Unique: Im9jfn8kOm-bZYFm0FLY6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC8083DD20;
	Fri, 26 Mar 2021 09:59:21 +0000 (UTC)
Received: from ovpn-115-44.ams2.redhat.com (ovpn-115-44.ams2.redhat.com [10.36.115.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF305C8AB;
	Fri, 26 Mar 2021 09:59:20 +0000 (UTC)
Message-ID: <1e0635a18f24cf4719e1604ec98d33977e92f322.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Date: Fri, 26 Mar 2021 10:59:19 +0100
In-Reply-To: <20210325144528.GB8998@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-2-fw@strlen.de>
	 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
	 <20210324200148.GL22603@breakpoint.cc>
	 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
	 <20210325124904.GB26567@breakpoint.cc>
	 <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
	 <20210325140603.GA8998@breakpoint.cc>
	 <027b859a6f5dd1f03ad6d1c56376dc19d5d2af5b.camel@redhat.com>
	 <20210325144528.GB8998@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Thu, 2021-03-25 at 15:45 +0100, Florian Westphal wrote:
> We might try to discuss this in the meeting, perhaps that would help?

I'm sorry, I had a conflicting (long) mtg, and later it was too late :(

I'm also sorry for the lack of clarity on my side.

Perhaps we can have a few mins mtg early next week, so can try to be
less confusing? If so, please bug me whenever it fits you - possibly
_not_ in the 13:15 range, as they are the rush hours for me.

Thanks!

Paolo

