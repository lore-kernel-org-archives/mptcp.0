Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE171
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620115759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pbp0wrFv8o97X2+aBVmL9Hz6T4FFjTd9ET79Ku4SAVM=;
	b=XaK/zx2LlKT4kUMkXowt9lWFagOBpsxBWeuiyRsG3CczJaCcTDvG0oktvquwxefywkcO5c
	ZufMVaDsDYkbIEJRtC1CTRHCdYsvxSKhg7c9c/nRZDnFBvMXr4v6O+YeRBnFXK7OPA9wcj
	KINLYjKvm2dxwUcgCUPTKD5eDoxsGhA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-2rza6ewmNM2urYQUVP8NTQ-1; Tue, 04 May 2021 04:09:18 -0400
X-MC-Unique: 2rza6ewmNM2urYQUVP8NTQ-1
Received: by mail-wr1-f72.google.com with SMTP id p19-20020adfc3930000b029010e10128a04so544705wrf.3
        for <mptcp@lists.linux.dev>; Tue, 04 May 2021 01:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Pbp0wrFv8o97X2+aBVmL9Hz6T4FFjTd9ET79Ku4SAVM=;
        b=pJ/5ePBbnegmPFuOERf7b0KaWUAJSmqs5otrl8FCXPQiVh0fyDA99zEbWKzhIhIWBb
         dtGSMvzifUulD0o+sburJ0aUk8o3+sW2X0R156sn5okOl2Grb6SoLaEf0zY9O2eCPncp
         r7iYnC50rwi573MaEPfh3HCzM3BGrGEtbA2+T6SuSU4tcCa0UrMaE9Y0n+7UhmrGA86S
         b+6azX4mOOpiFT0D8cGRI03Jk7Khlv7t/0OvYh59WlPdSmtfc0skkVHOTA5ceeIl5DaK
         aXE14s0Wm0PYJOgfdl5IWVvu/Ky+oCfs6RrBGnNa9f/CRvsnlEiVGJa80fbqndx0yoj/
         juxA==
X-Gm-Message-State: AOAM532AqpaRSK9/s6T31wgQ9oXGKEUaZ1L2nJkbP8/Nn4ax76sATfm9
	uxHGogf3GaEqrL5FWPt2uAWePnfhXEvONmt1pGjPbgVPugmadRwA9Q7pS/EQhCNNuTDNwK87vz3
	bKc91IFJUR/1pkdc=
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr30043391wri.216.1620115756768;
        Tue, 04 May 2021 01:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIGiC6QqviFIVUjFF+IX6lA/dxThP7vDJ6VoJx/LzXzhjcYYolFQBgUl5LEAkcFYy/NV+GrQ==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr30043363wri.216.1620115756440;
        Tue, 04 May 2021 01:09:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-108-140.dyn.eolo.it. [146.241.108.140])
        by smtp.gmail.com with ESMTPSA id q12sm831532wmj.7.2021.05.04.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 01:09:16 -0700 (PDT)
Message-ID: <3f3f0d4c89527c115cb382913c1e05946f28f5f8.camel@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 16/22] Squash-to: mptcp: validate the data
 checksum
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Date: Tue, 04 May 2021 10:09:15 +0200
In-Reply-To: <24c5410-3b1-5efe-57b6-e1ab374ca52a@linux.intel.com>
References: <cover.1619189145.git.pabeni@redhat.com>
	 <7a57898c62ea8d8476037db1b050cbd3d2a8133f.1619189145.git.pabeni@redhat.com>
	 <929ae094-622b-e477-6dc4-db5b5103c0@linux.intel.com>
	 <CAF6piCJ5Dv+5_LN-yaz0kdY_EM6LtyM7JmHY43ie+cFE_nf-=A@mail.gmail.com>
	 <24c5410-3b1-5efe-57b6-e1ab374ca52a@linux.intel.com>
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

Hello,

On Mon, 2021-05-03 at 13:10 -0700, Mat Martineau wrote:
> On Mon, 3 May 2021, Paolo Abeni wrote:
> > On Sat, Apr 24, 2021 at 1:42 AM Mat Martineau
> > <mathew.j.martineau@linux.intel.com> wrote:
> > > On Fri, 23 Apr 2021, Paolo Abeni wrote:
> > > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > > index 68efc81eaf2c..0ee568a99da1 100644
> > > > --- a/net/mptcp/subflow.c
> > > > +++ b/net/mptcp/subflow.c
> > > > @@ -829,10 +829,86 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> > > >       return true;
> > > > }
> > > > 
> > > > +static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *skb,
> > > > +                                           bool csum_reqd)
> > > > +{
> > > > +     struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> > > > +     struct csum_pseudo_header header;
> > > > +     u32 offset, seq, delta;
> > > > +     __wsum csum;
> > > > +     int len;
> > > > +
> > > > +     if (!csum_reqd)
> > > > +             return MAPPING_OK;
> > > > +
> > > > +     /* mapping already validated on previous traversal */
> > > > +     if (subflow->map_csum_len == subflow->map_data_len)
> > > > +             return MAPPING_OK;
> > > > +
> > > > +     /* traverse the receive queue, ensuring it contains a full
> > > > +      * DSS mapping and accumulating the related csum.
> > > > +      * Preserve the accoumlate csum across multiple calls, to compute
> > > > +      * the csum only once
> > > > +      */
> > > > +     delta = subflow->map_data_len - subflow->map_csum_len;
> > > > +     for (;;) {
> > > > +             seq = tcp_sk(ssk)->copied_seq + subflow->map_csum_len;
> > > > +             offset = seq - TCP_SKB_CB(skb)->seq;
> > > > +
> > > > +             /* if the current skb has not been accounted yet, csum its contents
> > > > +              * up to the amount covered by the current DSS
> > > > +              */
> > > > +             if (offset < skb->len) {
> > > > +                     len = min(skb->len - offset, delta);
> > > > +                     delta -= len;
> > > > +                     subflow->map_csum_len += len;
> > > > +                     subflow->map_data_csum = skb_checksum(skb, offset, len,
> > > > +                                                           subflow->map_data_csum);
> > > 
> > > skb_checksum() can only be used here if the data values are properly
> > > aligned for the 16-bit checksum. Think about the pathological case of all
> > > skbs with 1-byte payloads - you can't update the checksum until you have
> > > two bytes to feed to the checksum calculation (unless it's the last
> > > byte).
> > > 
> > > Also see the comment with checksum_partial() that ends up doing the work
> > > for skb_checksum() - "this function must be called with even lengths,
> > > except for the last fragment, which may be odd".
> > 
> > Thanks for pointing that out! I did not notice the comments (nor the
> > previous discussion on this topic, if any).
> > 
> > I'm wondering how e.g. UDP + cork cope with that ?!? in
> > ip_append_data() I don't see any special care for odd fragment lengths
> > and a after quick inspection to the x86 and the generic csum code I
> > *think* it should cope correctly even with odd, non terminal fragments
> > ?!?
> > 
> > Do you see any specific reason why do_csum() should produce uncorrect
> > results in the above scenario ?
> 
> I think the special handling is kind of buried - both ip_append_data() and 
> __ip_append_data() have a getfrag function pointer as a parameter. And 
> getfrag functions have an 'odd' parameter that gets propagated to 
> csum_block_add() by functions like ip_generic_getfrag() and 
> ip_reply_glue_bits(). Then csum_block_add() ends up doing a rotate to 
> handle the alignment.
> 
> Within skb_checksum(), csum_block_add() is also used, and it looks like it 
> handles odd/even lengths of fragments. So I think the checksums for 
> MPTCP-level skbs would need to be updated/combined similar to the way the 
> checksums for skb fragments are updated/combined inside __skb_checksum() 
> in order to correctly handle alignment.
> 
> 
> If you have data like this:
> 
> 0011223344556677
> 
> the checksum calculated all at once would look like:
> 
>    0011
> + 2233
> + 4455
> + 6677
> 
> But if you slice it up with odd-lengths like this:
> 
> 001122 | 3344 | 55 | 6677
> 
> then the checksum algorithm sees some padding (the 'p's):
> 
>    0011
> + 22pp
> + 3344
> + 55pp
> + 6677
> 
> which throws off the alignment and introduces artifacts from the padding.
> 
> 
> I think my statement earlier in this thread about the problems with 
> odd-length data didn't have all the details correct, but it seems like the 
> good news is that csum_block_add() could be the tool to handle it.

Thank you for the pointers and the detailed analisys. My understanding
is that combining the csum_partial() results via csum_block_add(),
tacking in account the current offset inside the DSS should address the
situation. I'll update the patches with that and hopefully post soon.

Cheers,

Paolo

