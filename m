Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5B34041D
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448556; cv=none; b=g2l1YrQs8jp0piaCzaFoUAsxcOiFgm3/sFBIzGU0GtrdTlSfLICPd/ipYa2tm8WmwkMo4VSEy+NHpCkD7LL/eNmlla6Js34jRsLwhNg6HhGtu1uIgNWg5DwnPU+9yJCau1J2tz/CjtGWrk3bMPM5VGXvY6166TDj1aF8Aa6Ebzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448556; c=relaxed/simple;
	bh=ojTXANnOmh6sdz9Lz5ObiP6Z0XQP8ZT/4g4fm2ZTqHk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZJbwzmWkufxUpQplXpX315hKzKV6Ayn7xOGo8jqQ/git0QyueDRXNc92EjIbKVEN6YSLJIF1OOLJZxIL2j0Na5FerA0qOa1oar8B+Iq2vaCAxzGYCyVsNy6GzbZTUPuoAX2CYWn1YMcFqlY7B9zMpw/tLM6y+ZUkdNjdyPShlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWpdKRjr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWpdKRjr"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ojTXANnOmh6sdz9Lz5ObiP6Z0XQP8ZT/4g4fm2ZTqHk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786448551; v=1; x=1787053351;
 b=KWpdKRjrWXaHmWiTJVSYfeFn+RZYtI1tUUs3xmjoVzF0smF+MjcPF8n1wq7Ni+2gjwxaLgTk
 hi19f5KorAI8YLrsOhQo02hHyyTP6GcszTvwWgBBOW+7gV5v0yuErjf7kwKAbVe3NJrN4Cs/5LA
 zSa23nUn7XoPQsqhk4NrBAwc=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta11.migadu.com with ESMTPS id a1b49774caf31d49;
	Tue, 11 Aug 2026 11:42:21 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 11:42:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <29653ddaaf4d94f66d1cb8abd3f627f2a2fa08bb@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next 5/6] mptcp: trim the duplicated skb head at
 receive enqueue
To: "Paolo Abeni" <pabeni@redhat.com>, "Geliang Tang" <geliang@kernel.org>,
 mptcp@lists.linux.dev
Cc: "Geliang Tang" <tanggeliang@kylinos.cn>
In-Reply-To: <0ac1a2d7-1426-4218-968b-deeea450a48c@redhat.com>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
 <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
 <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
 <4651fc61637f8be39654decec137010ffcd81991.camel@kernel.org>
 <0ac1a2d7-1426-4218-968b-deeea450a48c@redhat.com>

> >=20=20
>=20>  My description was inaccurate. This only occurs in the MPTCP out-o=
f-
> >  order scenario. It does not happen with TCP.
> >=20

Hi=20Paolo,

Sorry for the late feedback. Geliang and I also think the trim is not a g=
ood
way to address TLS issues.

> I mean: even for plain TCP skbs can sits in the receive queue with some
> heading bytes overlapping with already received ones, and skipped at
> read time due to `copied_seq`, how comes that TLS has no problem is suc=
h
> a case?


In TLS, 'tls_strp_check_queue_ok' will check this using 'TCK_SKB_CB(skb)-=
>seq',
like the comment said:

'''
        /* Make sure there's no duplicate data in the queue,
         * and the decrypted status matches.
         */
'''

It the check return false, the 'tls_strp_read_copy' will drop the frag_li=
st
and to use copy_mode.

This is imported by Jakub in 0d87bbd39d7('tls: strp: make sure the TCP sk=
bs
do not have overlapping data').=20

But=20I think it may missed one path in 'tls_rx_msg_size' before
'tls_strp_check_queue_ok', and that's where we met the problem in MPTCP:

'''
527         if (!strp->stm.full_len) {
528                 sz =3D tls_rx_msg_size(strp, strp->anchor);
...
536         }
537=20
538=20        if (!tls_strp_check_queue_ok(strp))
539                 return tls_strp_read_copy(strp, false);
'''

In 'tls_rx_msg_size', it use 'skb_copy_bits' directly without considering=
 overlap:


'''
2163 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
2164 {
...
2183         ret =3D skb_copy_bits(skb, strp->stm.offset, header, prot->p=
repend_size);
2184         if (ret < 0)
2185                 goto read_failure;
2186=20
2187=20        strp->mark =3D header[0];

'''

So, Geliang and I add a new helper to replace skb_copy_bits to address
this issue:

'''
static int tls_get_header(struct sk_buff *skb, int offset, void *buf, int=
 len)=20
{
=20       struct sk_buff *first =3D skb_shinfo(skb)->frag_list;
        struct sk_buff *iter;
        int copied =3D 0;=20
=20       u32 end_seq;

        if (likely(!first || first->len - offset >=3D len))
                return skb_copy_bits(skb, offset, buf, len);

        end_seq =3D TLS_SKB_CB(first)->seq + offset;

        for (iter =3D first; copied !=3D len; iter =3D iter->next) {
                int start =3D end_seq - TLS_SKB_CB(iter)->seq;
                int count;

                if (start > iter->len)
                        return -EFAULT;

                count =3D min_t(int, iter->len - start, len - copied);
                if (skb_copy_bits(iter, start, buf + copied, count))
                        return -EFAULT;

                copied +=3D count;
                end_seq =3D TLS_SKB_CB(iter)->seq + iter->len;
        }

        return 0;
}

'''

It works well without trim_head in KTLS over MPTCP, but regarding the TCP
reproducer: as the commit log in Jakub's commit, it really rare,
we cannot easily reproduce the overlap on plain TCP.

Could you please share your thoughts on our analysis and the TCP reproduc=
er?

Looking forward for your feedback.

Thanks
Gang



/

>=20
>=20/P
>
