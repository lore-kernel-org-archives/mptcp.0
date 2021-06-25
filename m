Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC556D10
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:26:32 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P8IVwV030646;
	Fri, 25 Jun 2021 08:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=pmGKMqSeBsmp8UjBq71+zFvripzRA4FB9TL7EiLaG9c=;
 b=W3SKMQvKRXRoir7iGmXozIehR8t8i35RAwB3Y/fg7shXbPZm3bC6yo+R9RkfyRS+WTc4
 /n58wYO1cokS62ZZw4ZIlPfPWm1Wx4/kZGONBj9cgvlMJM5TTK+5+yEHUFKHgMjbyqHO
 WzdH7rREavungSwBO3BQZ/e2y1Lr5F1WdazOvvJmqF/oQN1jfspvTAGfrQbYESSOaVqE
 JCJiukj2R7JEBAfzMX5Wc1vjbC5A+lXu7uEDpHoqAR1cWS/E90DN+5lqutkXKn+/0Y/U
 CpJrz3wWz5hpSLhNKr1uwEpix7DbENq0tYjQO5HmSd1ce7FE/dckoBSfaOOcpFUc2LgL +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by mx0b-00069f02.pphosted.com with ESMTP id 39d24a8smp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jun 2021 08:26:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P8FZpN004961;
	Fri, 25 Jun 2021 08:26:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by aserp3020.oracle.com with ESMTP id 39d2435n59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jun 2021 08:26:30 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15P8Lxbp021111;
	Fri, 25 Jun 2021 08:26:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 39d2435n4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jun 2021 08:26:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15P8QSAX018045;
	Fri, 25 Jun 2021 08:26:29 GMT
Received: from mwanda (/102.222.70.252)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 25 Jun 2021 01:26:27 -0700
Date: Fri, 25 Jun 2021 11:26:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev
Subject: [bug report] mptcp: refine mptcp_cleanup_rbuf
Message-ID: <YNWTLmF3Cne09pTT@mwanda>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: txAxzons5AKAjawB-J45SI56P3Skd1u3
X-Proofpoint-ORIG-GUID: txAxzons5AKAjawB-J45SI56P3Skd1u3

Hello Paolo Abeni,

The patch fde56eea01f9: "mptcp: refine mptcp_cleanup_rbuf" from Jun
22, 2021, leads to the following static checker warning:

	net/mptcp/protocol.c:464 mptcp_subflow_could_cleanup()
	warn: masking a bool

net/mptcp/protocol.c
   455  static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
   456  {
   457          const struct inet_connection_sock *icsk = inet_csk(ssk);
   458          bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
                ^^^^^^^^^^^^^^^^

   459          const struct tcp_sock *tp = tcp_sk(ssk);
   460  
   461          return (ack_pending & ICSK_ACK_SCHED) &&
                                      ^^^^^^^^^^^^^^
This is 1 so it works

   462                  ((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
   463                    READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
   464                   (rx_empty && ack_pending &
   465                                (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
                                       ^^^^^^^^^^^^^^^^
This is 8 so it doesn't work

   466  }

regards,
dan carpenter
