Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAF3FC2
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630394503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmll+1WHUG550aFVeO7ZXcQV6OCNigRpt31a3IQWgg0=;
	b=HxvZ1e2sMvD12+LiNlgfvo1FqaNdEs2MNBITiZw0xysuyrITWzrUZZbZIedM2W2XWPqIRd
	PODui1SkVOqV5fwSVHt82SnIeJhAh0IgF2JMphphyGpiHFmHxrhRV3Ah9L1+cJnwD8it8n
	K6lLF87OVP8amsOjRfBlcXFmAlMTgK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-3XV77i3IPSi06tAVQp-Q9Q-1; Tue, 31 Aug 2021 03:21:40 -0400
X-MC-Unique: 3XV77i3IPSi06tAVQp-Q9Q-1
Received: by mail-wr1-f72.google.com with SMTP id v6-20020adfe4c6000000b001574f9d8336so3742448wrm.15
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kmll+1WHUG550aFVeO7ZXcQV6OCNigRpt31a3IQWgg0=;
        b=MD+QQH7kqIYcCtUaiDKum2W3fMFQSDWwxXoWPgI37/Ruz9BnRZy+zvvvpCDU/g3okn
         WXO0bEsHtkuZZYZLQeMzB91phJeVS7EjLid3Rmqp/rKBZfbmb3vNmXYSRwWNs12VzXda
         ZiLLilVXlXULO6LsUayHDACfrXJkEdP9EQYhQ8osypPLkhQtCucabiNie8kD6ryKOLam
         3652t+0Mdrgp88WtNf+xa6CCjNRCr7/uUCZo7XJkb75iTE08hYKUkQBnA0Kzft3OdM66
         6+DDDuuGyAMwlt7BMYHCcy1AZ9V/pmyydnE4vavYNc9XVHreenlcduDZ6LRCZyRf/Vph
         JTrw==
X-Gm-Message-State: AOAM531SBQ4LjDb2jGC7He6tXV19IWNZqzW0CsNGaLWn5JrcxxNO9372
	fv7Kg2h42GRpM7WSsI3Z6LW2KQIMJ1VSO5BtvnTtQENGbW+qKWvlgTpJkDCyK057dAdLH9rvC8l
	On5BC2yhc0LG2ewQ=
X-Received: by 2002:adf:906c:: with SMTP id h99mr24483720wrh.8.1630394498865;
        Tue, 31 Aug 2021 00:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwThUiogQFCE5wTHnFaFL21GUErNglwStqs9hW4LzeAfQlC63cy2WCfQ0z+8i1iaTndeLq3ZQ==
X-Received: by 2002:adf:906c:: with SMTP id h99mr24483698wrh.8.1630394498649;
        Tue, 31 Aug 2021 00:21:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id p11sm1654862wma.16.2021.08.31.00.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 00:21:38 -0700 (PDT)
Message-ID: <4791c24b4b6003ee52998b8af2d6b30576ba9782.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible
 socket states
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: geliangtang@gmail.com, mptcp@lists.linux.dev
Date: Tue, 31 Aug 2021 09:21:37 +0200
In-Reply-To: <4f65e83-3f44-15a7-a9b8-95b4d74b745d@linux.intel.com>
References: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
	 <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
	 <4f65e83-3f44-15a7-a9b8-95b4d74b745d@linux.intel.com>
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

On Mon, 2021-08-30 at 11:10 -0700, Mat Martineau wrote:
> On Thu, 26 Aug 2021, Matthieu Baerts wrote:
> 
> > Hi Mat, Paolo,
> > 
> > On 26/08/2021 02:46, Mat Martineau wrote:
> > > Recent changes exposed a bug where specifically-timed requests to the
> > > path manager netlink API could trigger a divide-by-zero in
> > > __tcp_select_window(), as syzkaller does:
> > 
> > (...)
> > 
> > Thank you for the patch, the review and the testing!
> > 
> 
> More info on the testing: I was able to run syzkaller over the weekend, 
> and the error has not reoccurred in the last 5 days.
> 
> > This is now in our tree:
> > 
> > - ea8a43942429: mptcp: Only send extra TCP acks in eligible socket states
> > - Results: 99a16463048d..6d52100ab2ab
> > 
> > > Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
> > > Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > Checkpatch is yelling at me because a SoB is not present here.
> > 
> > @Paolo: sorry to ask this question but for the record, is it OK for you
> > if I add it? :)
> > 
> 
> Still an open question here about signoff (or changing author header) for 
> Paolo !

Yup, sorry, I thought I answered during the mtg. Whatever fits you, is
ok for me.

Cheers,

Paolo

