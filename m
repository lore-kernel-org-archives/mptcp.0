Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70B3B79F
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159612; cv=none; b=no8XhKv2//CUBq4qKUCzGdKM62HOPsMZOGS4IZVBXICiqgjmryh4Dl2bOvl/l31AAhUeipYKx6Fu/bnrtBI/WIAa8UefFV4xxYdQi4LHWqjNeoK0pnFSDrgyHVfjiLZ7nJ5dyEB9cq5tvADK9nHSad+zjSlsEwx4W7e1uw8dO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159612; c=relaxed/simple;
	bh=8KBBMUCx+sNPxqjnZBzvgja37a70mfWuELd6+PeFHG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gHq6dafEW6w8L5fcPk3fCdQOcOcf3KJtom/cSJUuwnGekZW4o+lnVqFk/f0MWbq1ymbINemlrPOnF+yl1xhuctVq+xQ2b/wMW0MumkT8HqNiuypsh51Q68yOyVPiSbnK+Kdu9w4hQzAvteEemZSdNgcAC22R/adYNTRV41DIpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAD7biYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAD7biYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710159608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dBz3pqqa/NfIAn3Nps5E9S3OF+EfTBcN3eZbuNKm7A=;
	b=LAD7biYkwdaeACkV3bBvR9DFgqFeZIXdqDRqB6wH3tzRXHaZqV7x7xNYQdypVxGc4y49VG
	Q3pOcAarKywQzcUIqIbCb6oe/8uovVhdRbYzTwj92NQZTNYxnaosFd1S1+3Zt3hc77pQgV
	e7P/cr7D0XYZCQd4vT2rPBklf0yEapg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-FYOHfW8KOb6LS8nQ74njbQ-1; Mon, 11 Mar 2024 08:20:07 -0400
X-MC-Unique: FYOHfW8KOb6LS8nQ74njbQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412d1f1ee7cso21353755e9.3
        for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 05:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159605; x=1710764405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dBz3pqqa/NfIAn3Nps5E9S3OF+EfTBcN3eZbuNKm7A=;
        b=SjH2HSTufmMdy5CyxGr4/ADi5r07DtU16lRgceLQVb4EnWNxoulNzDJSAx0SajNreW
         Agse1J/WfOYXg0Ra80oYr/5YsQbW7eC9kVIWBgORFHOzu2UuQZQG0W5j9GvbxC/cWi2z
         eUTzY1y0tp83WCh9w5Vz/Ya+riRaKMOAXFZggiCoRz2zOwvV07ZIM9Q7xfBWu9UO9JLA
         zMq5UKWxzm3V1cRVLrUabJqXSSRn9O0yZDO+o+KSFbYjUUW3dEPy4cgMtcnAR2w3ojhh
         miXHJe2TT6JmfyKU5n2hiDklEkEkdYUJJ1uRGFR5kl1xxQIVHvxy5tkNx1ZkSaT+2iCY
         FLgg==
X-Forwarded-Encrypted: i=1; AJvYcCVZAbktSJ7YKX+F4Du0K5lcIMR0H+tDnvIwr2pBnm3xSFH55qH5npQasuYgmK7V3z9iwWinQNgR+TAxZR47OIF4F/THrlI=
X-Gm-Message-State: AOJu0YxtcbyB0A+djctrF0Gob77yQfw5bpjalNsM5y4XpamfHjFqvEaK
	bx+8Jl/bUVl4Y3xab4aXtXRjOE3hCe1rxK2AV0zqyivTs3ZBrSpMTvWkOn5B3bSBm5KZWhpLdot
	iUXe2muUN/gTXijcLP1tuGanIwmfd3EUNY1Vxw/4IJNE6MPDb2H9/1pCtAlwa
X-Received: by 2002:a05:600c:a07:b0:413:1645:29a6 with SMTP id z7-20020a05600c0a0700b00413164529a6mr4752671wmp.22.1710159604607;
        Mon, 11 Mar 2024 05:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGui/IB7dBmq4ZCc5ptSo3Vwh8IAcNobt53bnN5sljVrqENQTYoYE/1Y4zLtiH6Rj3vWa6H/Q==
X-Received: by 2002:a05:600c:a07:b0:413:1645:29a6 with SMTP id z7-20020a05600c0a0700b00413164529a6mr4752644wmp.22.1710159604034;
        Mon, 11 Mar 2024 05:20:04 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b004132be1189bsm2105972wmb.45.2024.03.11.05.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:20:03 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:20:03 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
Message-ID: <Ze728xdGAhQIgHW5@dcaratti.users.ipa.redhat.com>
References: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
 <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org>
 <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
 <07323939-df11-4a2c-950e-de1412bb32b6@kernel.org>
 <CAKa-r6uQmQO+vD0UnkOHNbR-2EdxWoJArTpxMwJAiV7xC2Yz3A@mail.gmail.com>
 <636a37c1-ce8a-429a-a668-0c0abb125911@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <636a37c1-ce8a-429a-a668-0c0abb125911@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hello,

On Fri, Mar 08, 2024 at 10:54:31AM +0100, Matthieu Baerts wrote:
> Hi Davide,
> 
> On 08/03/2024 10:14, Davide Caratti wrote:
> > On Thu, Mar 7, 2024 at 5:33 PM Matthieu Baerts <matttbe@kernel.org> wrote:
> >>
> >> Hi Davide,
 
> What about also checking in mptcp_connect.sh that the counter is no
> longer incremented? I guess it should always be set to 0 after the
> patch, but it was not the case before, no?

correct. that would result in checking that $expect_ackrx didn't
increment when $cl_proto is "TCP" and $srv_proto is "MPTCP", right?

-- 
davide

