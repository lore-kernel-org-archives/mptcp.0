Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859670
	for <mptcp@lists.linux.dev>; Wed,  5 May 2021 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620209545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nBObelPK/N3t3fKBLKPUz7duKiHixauHsdhhMKMfA4=;
	b=H8RNi11pWOoxizrNHf8jL3WVT3bH3/BIamb44HyhSi8R9HJqeBiGgCSdPgs1WZh5TYjhji
	uo+l1YotZJJexjKn2NremgU76RKa6BuOPYcjM0VAjbr+/0H3xhl8xzZmPisQd6FAonmHHP
	IZvTSg5/OE2gs97UrtPPBqzDN4rtR0Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-rk-7uHbyMUSz0U_eK3d2hA-1; Wed, 05 May 2021 06:12:23 -0400
X-MC-Unique: rk-7uHbyMUSz0U_eK3d2hA-1
Received: by mail-wr1-f70.google.com with SMTP id t5-20020adfb7c50000b029010dd0bb24cfso513800wre.2
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 03:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/nBObelPK/N3t3fKBLKPUz7duKiHixauHsdhhMKMfA4=;
        b=l/FErGuxP3UF4Cn+FpPjsGX9e77EWoae7UXd5DGN/vsqTSLKxCK4BGbISJmbOS2EL4
         k2Cm8SICuY2uFfxqghwkbhbbzzRniic4FyLXlIRor3uarpl6Eu5C0oerQJFTN1/OeS0N
         +vCOcHvoZ5nbg38r0dlyjL1KxSH+QHVvZWMxYUDpKmRAcL7E3lrbj1T0+TqwhAFMijrj
         RKGLJSuFIPRUI1TUcDElX/tRYr88ODhFd2QfClzZOkhPqRXDNjCaUnMsOToAC8ziSDqe
         tQgi6TsremOOm/O9jF/9PCOZzWkC3POz8x/dNg9HL45ixT6D5NjoT8iCqUt0KhL6qP7T
         vUrg==
X-Gm-Message-State: AOAM530AUJ41Zk5NtrTeNr/GJ5klD/SeUEeDEVmQCN+BCWt3q/LHpLs5
	RBJ2i0+M01zPvxPgDZK5ko3/JwcJjg1KMcVDhMtRoxMvu7FvkLVaD3591kVGL3fW5FMWZBXYhvN
	QqwPXEvI+9RdQv36PCt9Hwe5EnfcMBE8PoGlYocW6SWqJINhoK28TmZsB9iLexhw2
X-Received: by 2002:a1c:2785:: with SMTP id n127mr32206057wmn.52.1620209541903;
        Wed, 05 May 2021 03:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUrc1wRqHLzTaaUpVcHOrtWcc5J13Gn2SOIzFJMhEiO0koWVNJhrqXg9Sy8rL31rlO4vEiaA==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr32206043wmn.52.1620209541692;
        Wed, 05 May 2021 03:12:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-108-140.dyn.eolo.it. [146.241.108.140])
        by smtp.gmail.com with ESMTPSA id c5sm18604123wrs.73.2021.05.05.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 03:12:21 -0700 (PDT)
Message-ID: <521bebd638f2baae1d511af64690b5c64b910d57.camel@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 00/22] mptcp: data checksum support
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Wed, 05 May 2021 12:12:20 +0200
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
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

On Tue, 2021-05-04 at 23:41 +0200, Paolo Abeni wrote:
> Changes from v5:
>  - none really, added patch lost in previous iteration due to PEBKAC

Note: self-tests are successful here (even with -C flag), but I did not
test interoperability with mptcp.org because...

... I think mptcp.org csum implementation does not respect RFC 8684.

In the current mptcp.org git repo
@f8b7c5e4a105b9d561eb5fb8cba26efbac861bc7,
file net/mptcp/mptcp_output.c, function mptcp_write_dss_mapping():

		csum = csum_partial(ptr - 2, 12, skb->csum);
                p16++;
                *p16++ = csum_fold(csum_partial(&hdseq, sizeof(hdseq), csum));

since the pseudo header len is 12, it looks like 4 bytes/32bits DSN is used.

But RFC 8684 section 3.3.1. says:

"""
   Note that the data sequence number used in the pseudo-header is
   always the 64-bit value, irrespective of what length is used in the
   DSS option itself. 
"""

Even RFC 6824 reports the same sentence, so it looks like I'm missing
some bits here?!?
Thanks!

Paolo

