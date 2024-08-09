Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B21917CF
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201536; cv=none; b=FbpYRsKDJAR1OL+7eR7O5sDRy7WrxFIDk3t7VI078roLQSW0tKN6RK+1p0RBK2+GCvEZHxKadye2D72HRXgtbHcJ/Pkp0TSXt7puQuqXPY7fpZi9wJLXi5DLXp2+KZCd5aJFCBYyge0n3BCayvH9cq1sVQQQ4KKbPUOfJp8orck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201536; c=relaxed/simple;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaXH8E00yhYN9q4kufnB/v76wcwhYMl8WwABrnyOQNvpRgN54M1uysPEDxFzzGekDy5MwnwkBd0hfkbxf2zZn4a8xRtBFRvLVwEXTdkN/x3bDGhbqDv/yKEaNBNTPfH8LFmtdQBBg+4wY88sB5StrrkuramM6IPlXOGq5EQ6Yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fhu1laHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fhu1laHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723201533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	b=Fhu1laHrajT9ZKxmT8ufjnISiLKcYPb5XEk36QAUAG6/s2ej4A7UTDM9md62LlQpBWB8VD
	JIAwvZENhV5Q925Q3G+m0Ctbo8lBgTdq+fNT4YGNUf3/ns6MxjAvsFwkmR7pJnLkWQqXUk
	RC7vaWQEHr64Fm8VLBY7U/HfAyzObgQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-v7TboLfKMBCkG85x3hY8lQ-1; Fri,
 09 Aug 2024 07:05:29 -0400
X-MC-Unique: v7TboLfKMBCkG85x3hY8lQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B383219560A2;
	Fri,  9 Aug 2024 11:05:27 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 619B719560A7;
	Fri,  9 Aug 2024 11:05:23 +0000 (UTC)
Date: Fri, 9 Aug 2024 13:05:19 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved
 size
Message-ID: <20240809110519.GA30788@asgard.redhat.com>
References: <20240809094321.GA8122@asgard.redhat.com>
 <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 09, 2024 at 12:42:19PM +0200, Matthieu Baerts wrote:
> Do you mind sending a v2 with these small fixes, so your patch can be
> directly applied in the net tree, please?

Sure, will do.

