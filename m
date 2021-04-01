Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639375F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1617271740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBVi5eVIaf+AnKjCAj3vcKav7e/w1AKQ7BBt5uJZ5qg=;
	b=Cbj0y8/UsueZPTmnoaCXjLz0NoS+Qg1MBBDIXVmOVXuqAg+I9dQf38smGlVIl7moSIieWv
	qD+3kpG5dWzEvQmBJxpFiiaeWSfF4II5d/OnXbl+ZVFJX58cGrIZqNRXRZxtUJEq9yvDGp
	aPb0lY9XcnXaBBbTRNehXzpScEbVc7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-bTytz3x0OEONbtzNwCicQw-1; Thu, 01 Apr 2021 06:08:56 -0400
X-MC-Unique: bTytz3x0OEONbtzNwCicQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066751018F70;
	Thu,  1 Apr 2021 10:08:54 +0000 (UTC)
Received: from ovpn-114-240.ams2.redhat.com (ovpn-114-240.ams2.redhat.com [10.36.114.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2851210023AC;
	Thu,  1 Apr 2021 10:08:48 +0000 (UTC)
Message-ID: <fe23f101aff3cbbe94a496374c4f7c3109d3eb2c.camel@redhat.com>
Subject: Re: [PATCH v3] mptcp: ensure there is unacked data at all subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev, 
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de
Date: Thu, 01 Apr 2021 12:08:48 +0200
In-Reply-To: <1617263626-66920-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1617263626-66920-1-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

I'm sorry for the late feeback.

On Thu, 2021-04-01 at 15:53 +0800, Yonglong Li wrote:
> MPTCP-level retransmit may take place if first subflow without data in
> its write queue and second subflow is likely to have unacked data left
> in its write queue. In this condition datamaybe double retransmitted.

Note that the above does not cause problems at the byte stream level,
and can improve the aggregate tput in some cases, as it could allow
faster forward progress when e.g. the substream which originally
handled the relevant data has experienced some congestion.

Do you have any specific scenario which is badly affected by the
current code? How does the self-tests behave on top of this patch?
(specifically: simult_flows.sh)

Side note: we could improve re-injection keeping explicit track at the
 mptcp_data_frag level of the already used subflows, and avoding them
at mptcp_subflow_get_retrans() time.

Thanks!

Paolo

